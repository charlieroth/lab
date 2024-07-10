#!/usr/bin/env python
# other.py
# ==== Other Features: `async for` and Async Generators + Comprehensions ====
# `async/await` enables `async for` to iterate over an asynchronous iterator,
# with the purpose of being able to call asynchronous code at each state when
# it is iterated over
#
# An extension of the asynchronous iterator concept is the asynchronous generator


import asyncio


async def mygen(u: int = 10):
    i = 0
    while i < u:
        yield 2**i
        i += 1
        await asyncio.sleep(0.1)


async def main():
    g = [i async for i in mygen()]
    f = [j async for j in mygen() if not (j // 3 % 5)]
    return g, f


if __name__ == "__main__":
    g, f = asyncio.run(main())
    print(g)
    print(f)
