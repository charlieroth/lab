#!/usr/bin/env python
# countsync.py

import time


def count():
    print("One")
    time.sleep(1)
    print("Two")


def main():
    for _ in range(3):
        count()


if __name__ == "__main__":
    main()

# ==== Output ====
#
# ❯ python countsync.py
# One
# Two
# One
# Two
# One
# Two
