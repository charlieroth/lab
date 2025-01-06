use std::collections::VecDeque;
use std::sync::{Arc, Condvar, Mutex};

pub struct Sender<T> {
    inner: Arc<Inner<T>>,
}

// Implement `Clone` for `Sender` manually because `#[derive(Clone)]` would de-sugar
// to making `T` clonable which `Arc<Inner<T>>` takes care of
impl<T> Clone for Sender<T> {
    fn clone(&self) -> Self {
        Sender {
            inner: Arc::clone(&self.inner),
        }
    }
}

impl<T> Sender<T> {
    pub fn send(&mut self, t: T) {
        // Obtain lock on the queue
        let mut queue = self.inner.queue.lock().unwrap();
        // Push the message onto the queue
        queue.push_back(t);
        // Drop the lock
        drop(queue);
        // Notify the single receiver (thread) that a msg is available
        self.inner.available.notify_one();
    }
}

pub struct Receiver<T> {
    inner: Arc<Inner<T>>,
}

impl<T> Receiver<T> {
    pub fn recv(&mut self) -> T {
        // Obtain a lock on the queue
        let mut queue = self.inner.queue.lock().unwrap();
        // Loop until a message is available (not a spin loop)
        loop {
            // Try to obtain message from queue
            match queue.pop_front() {
                // If message is available, return message
                Some(t) => return t,
                // If no message available
                None => {
                    // Block current thread until available message
                    // Gives up the lock, before sleeping, allowing sender to proceed
                    queue = self.inner.available.wait(queue).unwrap();
                }
            }
        }
    }
}

pub struct Inner<T> {
    queue: Mutex<VecDeque<T>>,
    available: Condvar,
}

pub fn channel<T>() -> (Sender<T>, Receiver<T>) {
    let inner = Inner {
        queue: Mutex::default(),
        available: Condvar::new(),
    };
    let inner = Arc::new(inner);
    (
        Sender {
            inner: inner.clone(),
        },
        Receiver {
            inner: inner.clone(),
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
        assert_eq!(rx.recv(), 42);
    }
}
