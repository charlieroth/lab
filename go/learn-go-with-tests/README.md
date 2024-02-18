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