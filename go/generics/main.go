package main

import "fmt"

type Number interface {
	int64 | float64
}

func Sum[T comparable, V Number](m map[T]V) V {
	var sum V
	for _, v := range m {
		sum += v
	}
	return sum
}

func main() {
	m := map[string]int64{
		"charlie": 26,
		"miranda": 24,
		"parker":  21,
	}

	m2 := map[string]float64{
		"charlie": 26.5,
		"miranda": 24.9,
		"parker":  21.1,
	}

	fmt.Println(Sum(m))
	fmt.Println(Sum(m2))
}
