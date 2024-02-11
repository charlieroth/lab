# Arrays

[Go Tour: Arrays](https://go.dev/tour/moretypes/6)

[Effective Go: Arrays](https://go.dev/doc/effective_go#arrays)

In Go, an array is a collection of elements of the same type with a
**fixed** size defined when the array is created/initialized.

An array's length is part of its type, so arrays cannot be resized.

Arrays are useful when planning the detailed layout of memory and 
sometimes can help avoid allocation.

The differences between arrays in Go and C are:

* Arrays are values. Assigning one array to another copies all the 
  elements.
* In particular, if you pass an array to a function, it will receive a 
  copy of the array, not a pointer to it.
* The size of an array is part of its type. The types [10]int and [20]int 
  are distinct.
