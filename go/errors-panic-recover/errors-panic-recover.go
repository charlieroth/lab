package main

import (
	"errors"
	"fmt"
	"log"
	"math"
	"os"
)

// Custom error type
type DivisionError struct {
	ValA int
	ValB int
	Msg  string
}

func (de DivisionError) Error() string {
	return de.Msg
}

// Definition of a sentinel error
var ErrorDivideByZero = errors.New("divide by zero")

func sqrt(f float64) (float64, error) {
	if f < 0 {
		return 0, errors.New("math: square root of negative number")
	}

	return math.Sqrt(f), nil
}

func div(a, b int) (int, error) {
	if b < 0 {
		return 0, ErrorDivideByZero
	}

	return (a / b), nil
}

func main() {
	f, err := os.Open("errors-panic-recover/README.md")
	if err != nil {
		log.Fatal(err)
	}
	defer f.Close()
	fmt.Println("opened file:", f.Name())

	var n float64 = 12.0
	res, err := sqrt(n)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Printf("sqrt(%v) = %v\n:", n, res)

	n = -13.0
	res, err = sqrt(n)
	if err != nil {
		log.Fatal(err)
	}

	a := 4
	b := 0
	_, err = div(a, b)
	if err != nil {
		log.Fatal(err)
	}
}
