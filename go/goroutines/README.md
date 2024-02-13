# Goroutines

[Effective Go: Goroutines](https://go.dev/doc/effective_go#goroutines)

A **goroutine** is a lightweight thread managed by the Go runtime

```go
go f(x, y, z)
```

starts a new goroutine

```go
f(x, y, z)
```

Starts the evaluation in the current goroutine, started by `main()`

Goroutines run in the same address space, so access to shared memory must be
synchronized. The `sync` package provides useful primitives for this
