package main

import (
	"fmt"
	"time"
)

func fibonacci(c, quit chan int) {
	x, y := 0, 1
	for {
		select {
		case c <- x:
			x, y = y, x+y
		case <-quit:
			fmt.Println("quit")
			return
		}
	}
}

func main() {
	c := make(chan int)
	quit := make(chan int)

	go func() {
		for range 10 {
			fmt.Println(<-c)
		}
		quit <- 1
	}()

	fibonacci(c, quit)

	c1 := make(chan string)
	c2 := make(chan string)

	go func() {
		time.Sleep(2 * time.Second)
		c1 <- "done"
	}()

	go func() {
		time.Sleep(1 * time.Second)
		c2 <- "done"
	}()

	for range 2 {
		select {
		case msg1 := <-c1:
			fmt.Printf("c1: %s\n", msg1)
		case msg2 := <-c2:
			fmt.Printf("c2: %s\n", msg2)
		}
	}
}
