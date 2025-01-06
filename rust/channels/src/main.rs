use std::sync::mpsc::channel;
use std::thread;

fn main() {
    let (sender, receiver) = channel();
    let sender2 = sender.clone();

    // First thread owns `sender`
    thread::spawn(move || {
        sender.send(1).unwrap();
    });

    // Second thread owns `sender2`
    thread::spawn(move || {
        sender2.send(2).unwrap();
    });

    let msg = receiver.recv().unwrap();
    let msg2 = receiver.recv().unwrap();
    assert_eq!(3, msg + msg2);
}
