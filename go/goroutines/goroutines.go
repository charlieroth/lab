package main

import (
	"fmt"
	"time"
)

func say(message string, times int) {
	for i := 0; i < times; i++ {
		time.Sleep(100 * time.Millisecond)
		fmt.Println(message)
	}
}

func main() {
	go say("Hey", 5)
	say("Bye", 5)
}
