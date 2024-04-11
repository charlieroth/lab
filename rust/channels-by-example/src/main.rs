use std::sync::mpsc::{Sender, Receiver};
use std::sync::mpsc;
use std::{thread, time};
use rand::{Rng, SeedableRng, rngs::StdRng};

static NTHREADS: i32 = 4;

fn main() {
    // Channels have two endpoints: the `Sender<T>` and the `Receiver<T>`,
    // where `T` is the type of the message to be transferred
    // (type annotation is superfluous)
    let (sender, receiver): (Sender<i32>, Receiver<i32>) = mpsc::channel();
    let mut handles = Vec::new();
    let mut rng = {
        let rng = rand::thread_rng();
        StdRng::from_rng(rng).unwrap()
    };

    for id in 0..NTHREADS {
        let ms_to_sleep = rng.gen_range(100..1000); 

        // The sender endpoint can be copied
        let sender_clone = sender.clone();
        // Each thread will send its id via the channel
        let handle = thread::spawn(move || {
            thread::sleep(time::Duration::from_millis(ms_to_sleep));
            // The thread takes ownership over `thread_sender`
            // Each thread queues a message in the channel
            sender_clone.send(id).unwrap();

            // Sending is non-blocking operation, the thread will continue
            // immediately after sending its message
            println!("thread {} finished", id);
        });

        handles.push(handle);
    }

    // All messages are collected
    let mut ids = Vec::with_capacity(NTHREADS as usize);
    for _ in 0..NTHREADS {
        // The `recv` method picks a message from the channel
        // `recv` will block the current thread if there are no messages available
        ids.push(receiver.recv()); 
    }

    // Wait for the threads to complete any remaining work
    for handle in handles {
        handle.join().expect("Oops! the thread handle panicked");
    }

    // Show the order in which the messages were sent
    println!("{:?}", ids);
}
