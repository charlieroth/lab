# Slices

[Go Tour: Slices](https://go.dev/tour/moretypes/7)

[Effective Go: Slices](https://go.dev/doc/effective_go#slices)

Slices are dynamically-sized, flexible views into the elements of an array

Most array programming in Go is done with slices rather than simple arrays

Slices hold references to an underlying array, and if you assign one slice
to another, both refer to the same array
