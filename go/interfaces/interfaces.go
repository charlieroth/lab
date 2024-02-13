package main

import (
	"fmt"
	"math"
)

type geometric interface {
	area() float64
	perimeter() float64
}

type rectangle struct {
	width  float64
	height float64
}

func (r rectangle) area() float64 {
	return r.width * r.height
}

func (r rectangle) perimeter() float64 {
	return (2 * r.width) + (2 * r.height)
}

type circle struct {
	radius float64
}

func (c circle) area() float64 {
	return math.Pi * c.radius * c.radius
}

func (c circle) perimeter() float64 {
	return math.Pi * 2 * c.radius
}

func measure(g geometric) {
	fmt.Println(g)
	fmt.Println("Area:", g.area())
	fmt.Println("Perimeter:", g.perimeter())
}

func main() {
	r := rectangle{5.0, 6.0}
	c := circle{4.0}
	measure(r)
	measure(c)
}
