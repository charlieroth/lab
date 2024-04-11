use std::sync::Arc;
use tokio::sync::Mutex;
use tokio::spawn;

#[tokio::main]
async fn main() {
    let data = Arc::new(Mutex::new(0));
    println!("data: {:?}", *data.lock().await);

    let data1 = Arc::clone(&data);
    let t1 = spawn(async move {
        let mut lock = data1.lock().await;
        *lock += 1;
    });
    
    let data2 = Arc::clone(&data);
    let t2 = spawn(async move {
        let mut lock = data2.lock().await;
        *lock += 1;
    });

    t1.await.unwrap();
    t2.await.unwrap();
    let result = data.lock().await;
    assert_eq!(*result, 2);
    println!("data: {:?}", *result);
}
