package main

import (
	"fmt"

	"github.com/charlieroth/lab/go/packages/math"
)

func main() {
	nums := []float64{1.0, 2.0, 3.0, 4.0}
	avg := math.Average(nums)
	fmt.Printf("Average of %v = %v\n", nums, avg)
}
