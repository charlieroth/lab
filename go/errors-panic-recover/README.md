# Errors, Panic, Recover

[Earthly: Go Errors](https://earthly.dev/blog/golang-errors/)

The most common use Go technique for issuing errors is to return the errors
as the last value in a return

Panics are used to fail fast on errors that shouldn't occur during normal
operation, or that a program is not prepared to handle gracefully

Panic recovery depends on **deferred functions**

## `error` Type

The `error` type is an `interface` type. An `error` variable represents
a variable that can describe itself as a string

```go
type error interface {
  Error() string
}
```
