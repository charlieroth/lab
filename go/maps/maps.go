package main

import "fmt"

func main() {
	// initialize map
	people := map[string]int{
		"Rob Pike":         68,
		"Robert Griesemer": 60,
		"Ken Thompson":     81,
	}
	for name, age := range people {
		fmt.Printf("%s is %d years old\n", name, age)
	}
	fmt.Println("---------------------------")

	// update value in map
	people["Rob Pike"] += 1
	for name, age := range people {
		fmt.Printf("%s is %d years old\n", name, age)
	}
	fmt.Println("---------------------------")

	delete(people, "Rob Pike")
	for name, age := range people {
		fmt.Printf("%s is %d years old\n", name, age)
	}
}
