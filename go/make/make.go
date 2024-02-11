package main

import (
	"fmt"
	"reflect"
)

func main() {
	// the slice `a` now refers to a new array of 10 ints
	// initialized to 0, with no capacity
	var a []int = make([]int, 10)
	fmt.Printf("a \tLen: %v \tCap: %v\n", len(a), cap(a))
	fmt.Println(reflect.ValueOf(a).Type(), reflect.ValueOf(a).Kind())

	// the slice `b` now refers to a new array of 10 ints
	// intialized to 0, with a capacity of 20
	b := make([]string, 10, 20)
	fmt.Printf("b \tLen: %v \tCap: %v\n", len(b), cap(b))
	fmt.Println(reflect.ValueOf(b).Type(), reflect.ValueOf(b).Kind())

	employees := make(map[string]int)
	employees["Mark"] = 10
	employees["Sandy"] = 20
	fmt.Println(employees)

	// The value of a channel is a memory address, which acts as a medium
	// through which goroutines send and receive data to communicate
	number := make(chan int)
	fmt.Printf("number \t Channel Type: %T\t Channel Value: %v\n", number, number)
}
