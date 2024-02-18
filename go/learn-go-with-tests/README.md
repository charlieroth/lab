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