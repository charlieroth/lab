package main

import "fmt"

func main() {
	primes := [6]int{2, 3, 5, 7, 11, 13}
	var s []int = primes[1:4]
	fmt.Printf("s: %v\n", s)
	fmt.Printf("primes: %v\n", primes)

	// Because `s` is a reference to the `primes` array starting at position 1
	// by modifying position 0 of `s`, position 1 of `primes` is also modified
	s[0] = 10
	fmt.Printf("s: %v\n", s)
	fmt.Printf("primes: %v\n", primes)

	// Output
	// s: [3 5 7]
	// primes: [2 3 5 7 11 13]
	// s: [10 5 7]
	// primes: [2 10 5 7 11 13]
}
