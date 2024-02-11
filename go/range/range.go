package main

import "fmt"

func main() {
	// range over slice
	var pow = []int{1, 2, 4, 8, 16, 32}
	for i, v := range pow {
		fmt.Printf("2**%d = %d\n", i, v)
	}

	// range over key, value of map
	kvs := map[string]string{
		"a": "apple",
		"b": "banana",
	}
	for k, v := range kvs {
		fmt.Printf("%v is for %v\n", k, v)
	}

	// range over key of map
	for k := range kvs {
		fmt.Printf("key: %v\n", k)
	}

	// range over string
	for i, c := range "Charlie Roth" {
		fmt.Printf("%v, %v\n", i, c)
	}
}
