#!/usr/bin/env python
# asyncq.py

# ==== Using a Queue ====
# `asyncio` provides a queue classes designed to be similar to classes of the `queue` module

import asyncio
import random
import time
import os
import argparse


async def makeitem(size: int = 5) -> str:
    return os.urandom(size).hex()


async def randsleep(caller: str) -> None:
    i = random.randint(0, 10)
    print(f"{caller} - sleeping for {i} seconds")
    await asyncio.sleep(i)


async def produce(name: int, q: asyncio.Queue) -> None:
    n = random.randint(1, 10)

    # Synchronous loop for each single producer
    for _ in range(n):
        await randsleep(caller=f"Producer({name})")
        i = await makeitem()
        t = time.perf_counter()
        await q.put((i, t))
        print(f"Producer({name}) added <{i}> to queue")


async def consume(name: int, q: asyncio.Queue) -> None:
    while True:
        await randsleep(caller=f"Consumer({name})")
        i, t = await q.get()
        now = time.perf_counter()
        print(f"Consumer({name}) - got element <{i}> in {now-t:0.5f} seconds")
        q.task_done()


async def main(nprod: int, ncon: int) -> None:
    q = asyncio.Queue()
    producers = [asyncio.create_task(produce(n, q)) for n in range(nprod)]
    consumers = [asyncio.create_task(consume(n, q)) for n in range(ncon)]
    await asyncio.gather(*producers)
    await q.join()  # Implicitly awaits consumers too
    for c in consumers:
        c.cancel()


if __name__ == "__main__":
    random.seed(444)
    parser = argparse.ArgumentParser()
    parser.add_argument("-p", "--nprod", type=int, default=5)
    parser.add_argument("-c", "--ncon", type=int, default=10)
    ns = parser.parse_args()
    start = time.perf_counter()
    asyncio.run(main(**ns.__dict__))
    end = time.perf_counter() - start
    print(f"Total time: {end:0.2f} seconds")

# ==== Output ====
# ❯ python asyncq.py -p 2 -c 2
# Producer(0) - sleeping for 4 seconds
# Producer(1) - sleeping for 4 seconds
# Consumer(0) - sleeping for 7 seconds
# Consumer(1) - sleeping for 4 seconds
# Producer(0) added <8407aab5ae> to queue
# Producer(0) - sleeping for 4 seconds
# Producer(1) added <6a2e8e4e69> to queue
# Consumer(1) - got element <8407aab5ae> in 0.00051 seconds
# Consumer(1) - sleeping for 8 seconds
# Consumer(0) - got element <6a2e8e4e69> in 2.99919 seconds
# Consumer(0) - sleeping for 10 seconds
# Producer(0) added <fecb9b6c9a> to queue
# Producer(0) - sleeping for 7 seconds
# Consumer(1) - got element <fecb9b6c9a> in 4.00098 seconds
# Consumer(1) - sleeping for 8 seconds
# Producer(0) added <c7bb9e2efa> to queue
# Producer(0) - sleeping for 4 seconds
# Consumer(0) - got element <c7bb9e2efa> in 1.99860 seconds
# Consumer(0) - sleeping for 7 seconds
# Producer(0) added <4f8736600f> to queue
# Producer(0) - sleeping for 1 seconds
# Consumer(1) - got element <4f8736600f> in 0.99934 seconds
# Consumer(1) - sleeping for 6 seconds
# Producer(0) added <0984cd9bd3> to queue
# Consumer(0) - got element <0984cd9bd3> in 3.99829 seconds
# Consumer(0) - sleeping for 9 seconds
# Total time: 24.01 seconds
