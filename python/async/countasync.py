#!/usr/bin/env python
# countasync.py

import asyncio


async def count():
    print("One")
    await asyncio.sleep(1)
    print("Two")


async def main():
    await asyncio.gather(count(), count(), count())


if __name__ == "__main__":
    asyncio.run(main())

# ==== Output ====
#
# ❯ python countasync.py
# One
# One
# One
# Two
# Two
# Two
