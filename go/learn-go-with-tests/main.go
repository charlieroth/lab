package main

import (
	"os"

	mocking "github.com/charlieroth/lab/go/learn-go-with-tests/mocking"
)

func main() {
	sleeper := &mocking.DefaultSleeper{}
	mocking.Countdown(os.Stdout, sleeper)
}