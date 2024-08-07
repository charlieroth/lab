#!/usr/bin/env python
# chained.py
#
# ==== Chaining Coroutines ====
# A key feature of coroutines is that they can be chained together
# A coroutine object is awaitable, so another coroutine can `await` it
# This allows programs to be broken down into smaller, managable, recyclable coroutines

import asyncio
import random
import time
import sys


async def part1(n: int) -> str:
    i = random.randint(0, 10)
    print(f"part1({n}) - sleeping for {i} seconds")
    await asyncio.sleep(i)
    result = f"result{n}-1"
    print(f"Returning part1({n}) == {result}")
    return result


async def part2(n: int, arg: str) -> str:
    i = random.randint(0, 10)
    print(f"part2({n, arg}) - sleeping for {i} seconds")
    await asyncio.sleep(i)
    result = f"result{n}-2 derived from {arg}"
    print(f"Returning part2({n, arg}) == {result}")
    return result


async def chain(n: int) -> None:
    start = time.perf_counter()
    p1 = await part1(n)
    p2 = await part2(n, p1)
    end = time.perf_counter() - start
    print(f"--> Chained result{n} => {p2} (took {end:0.2f} seconds)")


async def main(*args):
    await asyncio.gather(*(chain(i) for i in args))


if __name__ == "__main__":
    random.seed(444)
    args = [1, 2, 3] if len(sys.argv) == 1 else map(int, sys.argv[1:])
    start = time.perf_counter()
    asyncio.run(main(*args))
    end = time.perf_counter() - start
    print(f"Program finished in {end:0.2f} seconds")

# ==== Output ====
# ❯ python chained.py 9 6 3
# part1(9) - sleeping for 4 seconds
# part1(6) - sleeping for 4 seconds
# part1(3) - sleeping for 0 seconds
# Returning part1(3) == result3-1
# part2((3, 'result3-1')) - sleeping for 4 seconds
# Returning part1(9) == result9-1
# part2((9, 'result9-1')) - sleeping for 7 seconds
# Returning part1(6) == result6-1
# part2((6, 'result6-1')) - sleeping for 4 seconds
# Returning part2((3, 'result3-1')) == result3-2 derived from result3-1
# --> Chained result3 => result3-2 derived from result3-1 (took 4.00 seconds)
# Returning part2((6, 'result6-1')) == result6-2 derived from result6-1
# --> Chained result6 => result6-2 derived from result6-1 (took 8.00 seconds)
# Returning part2((9, 'result9-1')) == result9-2 derived from result9-1
# --> Chained result9 => result9-2 derived from result9-1 (took 11.00 seconds)
# Program finished in 11.00 seconds
