package main

import "fmt"

type person struct {
	name string
	age  int
}

func newPerson(name string) *person {
	p := person{name: name}
	p.age = 42
	return &p
}

func main() {
	// Create new struct, field names can be omitted
	// and the position of the values will be assigned
	// to the appropriate field
	bob := person{"Bob", 20}
	fmt.Println(bob)

	alice := person{name: "Alice", age: 30}
	fmt.Println(alice)

	// Omitted fields will be zero-valued
	fred := person{name: "Fred"}
	fmt.Println(fred)

	fmt.Println(newPerson("John"))

	// access struct fields with dot notation
	sean := person{name: "Sean", age: 50}
	fmt.Println("sean's age:", sean.age)

	seanPtr := &sean
	fmt.Println("seanPtr's age:", seanPtr.age)

	fmt.Println("seanPtr's birthday is today!")
	seanPtr.age = 51
	fmt.Println("sean's age:", sean.age)
	fmt.Println("seanPtr's age:", seanPtr.age)
}
