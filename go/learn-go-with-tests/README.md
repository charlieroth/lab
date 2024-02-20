# Learn Go with Tests

Following lessons from https://quii.gitbook.io/learn-go-with-tests

## Benchmarking

Writing benchmarks in Go is a first-class feature of the language and tooling.

Writing a benchmark is very similar to writing a test. The `b.N` is a number that is determined by the `testing` package.

```go
func BenchmarkMyFunc(b *testing.B) {
  for i := 0; i < b.N; i++ {
    MyFunc()
  }
}
```

To run the benchmark use the following command:

```bash
$ go test -bench=.
```

The output will be similar to this:

```bash
goos: darwin
goarch: amd64
pkg: github.com/charlieroth/lab/go/learn-go-with-tests/iteration
cpu: VirtualApple @ 2.50GHz
BenchmarkRepeat-12      15677230                76.51 ns/op
PASS
ok      github.com/charlieroth/lab/go/learn-go-with-tests/iteration     1.684s
```

## Coverage

Go's built-in testing toolkit also contains a coverage tool

Understanding the coverage of your tests in your Go application can be done by running the command:

```bash
$ go test -cover
```

The output will look like so:

```bash
PASS
coverage: 88.9% of statements
ok      github.com/charlieroth/lab/go/learn-go-with-tests/helloworld    0.323s
```

## Testing Equality

Go does not let you use equality operators with slices. A function could be written to perform this equality assertion. Go has a `reflect` package containing a function `reflect.DeepEqual`, which is useful for seeing if _any_ two variable are the same.

While the `reflect` package is useful it can reduce the type-safety of your code

## Dependency Injection

**If a function can not easily be tested**, this is usually due to hard-wired dependencies or global state such as a global database connection pool. Dependency Injection encourages you to "inject" the database dependency, via an `interface`, to mock what you want to control in your tests.

A good application of Dependency Injection lends your code to be re-usable in different contexts. Usually the first "new" context your code can be used in is a test case. In the future maybe your function can be used by someone else for their use case.

## Mocking

If you agree that _slow tests ruin developer productivity_, then a making a slow test, fast, is something that should be prioritized. When dealing with a slow test due to dependency in the function using Mocking and Dependency Injection can help you achieve the same level of verification without the slow down.

Like most abstractions in Go, the utilization of `interface`s is key to effectively Mocking

## Concurrency

_goroutines_ are the basic unit of concurrency in Go

_channels_ help organize and control communication between the different processes, allowing programs to avoid _race condition_ bugs

## Synchronization

`sync.WaitGroup` is a convenient way of synchronizing concurrent processes

A `WaitGroup` waits for a collection of _goroutines_ to finish. The main _goroutine_ calls `wg.Add(int)`
to set the number of _goroutines_ to wait for. Then each of the _goroutines_ runs and calls `wg.Done()` when
finished. At the same time, `wg.Wait()` can be use to block until all goroutines have finished

Using a `WaitGroup` with a number of _goroutine_ calls is not enough to safely synchronize concurrent operations.

Additionally, the resource you are trying to modify concurrently should also have a mechanism that ensures that
only one operation is executing on this data value at a time. In Go this mechanism is a `sync.Mutex`.

Idiomatically, a `sync.Mutex` is part of a struct that "guards" the data resource the program will modify
concurrently

```go
type Counter struct {
  mu sync.Mutex
  value int
}
```

When the program is concurrently modifying the piece of data, the mutex is first locked, the value is modifying, and then the mutex is unlocked allowing the program to continue to proceed.

When learning how to write safe, concurrent Go programs, it can be difficult to know when to use `sync.Mutex` or a _channel_. Luckily the Go team has documented some of this knowledge to help guide developers.

[Go Wiki: Use a sync.Mutex or a channel](https://go.dev/wiki/MutexOrChannel)

A simple summary is:

- Channel
  - Passing ownership of data
  - Distributing units of work
  - Communicating async results
- Mutex
  - Caches
  - State

## Context

The `context` package helps us manage long-running processes

One of the main points of context is that it is a consistent way of offering cancellation.

From [go doc](https://golang.org/pkg/context/)

> Incoming requests to a server should create a Context, and outgoing calls to servers should accept a Context. The chain of function
> calls between them must propagate the Context, optionally replacing it with a derived Context created using WithCancel, WithDeadline,
> WithTimeout, or WithValue. When a Context is canceled, all Contexts derived from it are also canceled.

From [Go Blog: Context](https://blog.golang.org/context)

> At Google, we require that Go programmers pass a Context parameter as the first argument to every function on the call path between
> incoming and outgoing requests. This allows Go code developed by many different teams to interoperate well. It provides simple control > over timeouts and cancelation and ensures that critical values like security credentials transit Go programs properly.
