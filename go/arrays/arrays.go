package main

import "fmt"

func main() {
	var name [2]string
	name[0] = "Charlie"
	name[1] = "Roth"
	fmt.Println(name[0], name[1])

	primes := [6]int{2, 3, 5, 7, 11, 13}
	fmt.Println(primes)
}
