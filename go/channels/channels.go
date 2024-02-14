package main

import "fmt"

func producer(c chan int) {
	for i := 0; i < 10; i++ {
		c <- i
	}
	close(c)
}

func sum(s []int, c chan int) {
	sum := 0
	for _, v := range s {
		sum += v
	}
	c <- sum // send sum to c
}

func main() {
	c := make(chan int)
	s := []int{1, 2, 3, 4, 5}
	// process first half of slice
	go sum(s[:len(s)/2], c)
	// process second half of slice
	go sum(s[len(s)/2:], c)
	// recieve first value from c
	x := <-c
	// recieve second value from c
	y := <-c
	fmt.Println(x, y, x+y)

	go producer(c)
	for v := range c {
		fmt.Printf("received %d from producer\n", v)
	}
}
