package main

import (
	"fmt"
	"time"
)

func returnTheAnswer() int {
	return 42
}

func main() {
	y := 3
	x := 1
	fmt.Printf("x: %v, y: %v\n", x, y)

	if x > 0 {
		fmt.Println("x > 0")
	}

	var min int
	if x <= y {
		min = x
	} else {
		min = y
	}

	fmt.Println("The minimum of x and y is:", min)

	if x := returnTheAnswer(); x <= y {
		fmt.Println("x is still less than y")
	}

	today := time.Now()
	switch today.Day() {
	case 5:
		fmt.Println("Today is the 5th, clean the house")
	case 10:
		fmt.Println("Today is the 10th, mow the lawn")
	case 15:
		fmt.Println("Today is the 15th, visit the doctor")
	case 16, 17, 18:
		fmt.Println("Either 16th, 17th, 18th, visit your mom")
	case 25:
		fmt.Println("Today is the 25th, go to grocery store")
	case 31:
		fmt.Println("Party!!!")
	default:
		fmt.Println("No info for today")
	}

	switch anotherToday := time.Now(); {
	case anotherToday.Day() < 5:
		fmt.Println("Clean your house")
	case anotherToday.Day() <= 10:
		fmt.Println("Mow the lawn")
	case anotherToday.Day() <= 15:
		fmt.Println("Visit the doctor")
	default:
		fmt.Println("No info for today")
	}

	switch today.Day() {
	case 5:
		fmt.Println("Clean your house")
		fallthrough
	case 10:
		fmt.Println("Mow the lawn")
		fallthrough
	case 15:
		fmt.Println("Visit the doctor")
		fallthrough
	case 31:
		fmt.Println("Party tonight")
	default:
		fmt.Println("No info for today")
	}
}
