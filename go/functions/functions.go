package main

import "fmt"

func plus(a int, b int) int {
	return a + b
}

func plusPlus(a, b, c int) int {
	return a + b + c
}

func vals() (int, int) {
	return 3, 7
}

func sum(nums ...int) int {
	fmt.Print(nums, " ")
	total := 0
	for _, num := range nums {
		total += num
	}

	return total
}

func rectangle(l int, w int) (area int) {
	var perimeter int
	perimeter = 2 * (l + w)
	fmt.Println("Perimeter:", perimeter)
	area = l * w
	return // Return state without specific variable name
}

func main() {
	res := plus(1, 2)
	fmt.Println("1 + 2 =", res)

	res = plusPlus(1, 2, 3)
	fmt.Println("1 + 2 + 3 =", res)

	val1, val2 := vals()
	res = plus(val1, val2)
	fmt.Printf("%v + %v = %v\n", val1, val2, res)

	_, val3 := vals()
	res = plus(val3, val3)
	fmt.Printf("%v + %v = %v\n", val3, val3, res)

	theSum := sum(1, 2, 3, 4, 5)
	fmt.Println("theSum =", theSum)

	nums := []int{1, 2, 3, 4, 5}
	theSum = sum(nums...)
	fmt.Println("theSum =", theSum)
}
