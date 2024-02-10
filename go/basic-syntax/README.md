# Basics

[go.dev Getting Started](https://go.dev/doc/tutorial/getting-started)

Given the following directory tree and the following program we can explore
some of the main ideas when it comes to syntax and a basic `go` program

```bash
$ mkdir hello
$ cd hello
$ go mod init github.com/example/hello
$ touch hello.go
$ cd ..
$ tree .

hello/
├── hello.go
└── go.mod
```

```go
package main

import "fmt"

func main() {
  fmt.Println("Hello, world!")
}
```

## Modules & Dependencies

To manage dependencies, so your code can import packages contained in other
modules, that module is defined by a `go.mod` file that tracks the modules
that provide those packages

To enable dependency tracking, by creating a `go.mod` file, run the command
[`go mod init`](https://go.dev/ref/mod#go-mod-init) with the name of the module
your code will be in. Typically module names are something like: `github.com/mymodule`

An example module, `hello.go`:

## Packages & Code

A package is a way to group functions, and it's made up of all the files in the
same directory

Implementing a `main` function will execute by default when you run the `main`
package
