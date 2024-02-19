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
