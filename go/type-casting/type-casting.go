package main

import (
	"fmt"
	"math"
)

func main() {
	var x, y int = 3, 4
	fmt.Printf("%d, %d\n", x, y)
	var f float64 = math.Sqrt(float64(x*x + y*y))
	fmt.Printf("%f\n", f)
	var z uint = uint(f)
	fmt.Printf("%d\n", z)
}
