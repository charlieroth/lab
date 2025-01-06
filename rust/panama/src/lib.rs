use std::collections::VecDeque;
use std::sync::{Arc, Condvar, Mutex};

pub struct Inner<T> {
    queue: VecDeque<T>,
    senders: usize,
}

pub struct Shared<T> {
    inner: Mutex<Inner<T>>,
    available: Condvar,
}

pub struct Sender<T> {
    shared: Arc<Shared<T>>,
}

// Implement `Clone` for `Sender` manually because `#[derive(Clone)]` would de-sugar
// to making `T` clonable which `Arc<Inner<T>>` takes care of
impl<T> Clone for Sender<T> {
    fn clone(&self) -> Self {
        let mut inner = self.shared.inner.lock().unwrap();
        inner.senders += 1;
        drop(inner);

        Sender {
            shared: Arc::clone(&self.shared),
        }
    }
}

impl<T> Drop for Sender<T> {
    fn drop(&mut self) {
        let mut inner = self.shared.inner.lock().unwrap();
        inner.senders -= 1;
        let was_last = inner.senders == 0;
        drop(inner);
        if was_last {
            self.shared.available.notify_one();
        }
    }
}

impl<T> Sender<T> {
    pub fn send(&mut self, t: T) {
        // Obtain lock on the queue
        let mut inner = self.shared.inner.lock().unwrap();
        // Push the message onto the queue
        inner.queue.push_back(t);
        // Drop the lock
        drop(inner);
        // Notify the single receiver (thread) that a msg is available
        self.shared.available.notify_one();
    }
}

pub struct Receiver<T> {
    shared: Arc<Shared<T>>,
    buffer: VecDeque<T>,
}

impl<T> Receiver<T> {
    pub fn recv(&mut self) -> Option<T> {
        // If there are some items from the last `recv` call
        if let Some(t) = self.buffer.pop_front() {
            return Some(t);
        }
        // If there are no items in the buffer, `recv` has not been called yet
        // then a lock needs to be acquired.
        //
        // This is an optimization to prevent a lock from being acquired
        // on every send, therefore reducing lock contention and faster lock
        // acquisition. Instead a lock is only acquired once every time there
        // were no additional sends between every time a lock occurs.

        // Obtain a lock on the queue
        let mut inner = self.shared.inner.lock().unwrap();
        // Loop until a message is available (not a spin loop)
        loop {
            // Try to obtain message from queue
            match inner.queue.pop_front() {
                // If message is available
                Some(t) => {
                    // If the queue is not empty, place all items into the buffer
                    if !inner.queue.is_empty() {
                        std::mem::swap(&mut self.buffer, &mut inner.queue);
                    }
                    return Some(t);
                }
                // If no message available and no senders remain
                None if inner.senders == 0 => return None,
                // If no message available
                None => {
                    // Block current thread until available message
                    // Gives up the lock, before sleeping, allowing sender to proceed
                    inner = self.shared.available.wait(inner).unwrap();
                }
            }
        }
    }
}

impl<T> Iterator for Receiver<T> {
    type Item = T;
    fn next(&mut self) -> Option<Self::Item> {
        self.recv()
    }
}

pub fn channel<T>() -> (Sender<T>, Receiver<T>) {
    let inner = Inner {
        queue: VecDeque::default(),
        senders: 1,
    };
    let shared = Shared {
        inner: Mutex::new(inner),
        available: Condvar::new(),
    };
    let shared = Arc::new(shared);
    (
        Sender {
            shared: shared.clone(),
        },
        Receiver {
            shared: shared.clone(),
            buffer: VecDeque::new(),
        },
    )
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn ping_pong() {
        let (mut tx, mut rx) = channel();
        tx.send(42);
        assert_eq!(rx.recv(), Some(42));
    }

    #[test]
    fn closed_tx() {
        let (tx, mut rx) = channel::<()>();
        drop(tx);
        assert_eq!(rx.recv(), None);
    }

    #[test]
    fn closed_rx() {
        let (mut tx, rx) = channel();
        drop(rx);
        tx.send(42);
    }

    #[test]
    fn iterator_rx() {
        let (mut tx, rx) = channel();
        tx.send(1);
        tx.send(2);
        tx.send(3);
        tx.send(4);
        drop(tx);
        let mut rx_iter = rx.into_iter();
        assert_eq!(rx_iter.next(), Some(1));
        assert_eq!(rx_iter.next(), Some(2));
        assert_eq!(rx_iter.next(), Some(3));
        assert_eq!(rx_iter.next(), Some(4));
        assert_eq!(rx_iter.next(), None);
    }
}
