# Types and Type Assertions

A **type assertion** provides access to an interface value's underlying
concrete value

This statement asserts that the interface value `i` holds the concrete type
`T` and assigns the underlying `T` value to the variable `i`

If `i` does not hold a `T`, the statement will trigger a panic

```go
t := i.(T)
```

Additionally, a type assertion can return two values:

* The underlying value
* Boolean value that reports whether the assertion succeeded

```go
t, ok := i.(T)
```

