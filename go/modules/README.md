# Modules

[Go Blog: Modules](https://go.dev/blog/using-go-modules)

Modules are a group of related packages that are versioned and distributed
together

Specify requirements of a project:

* List all required dependencies
* Track specific versions of installed dependencies

Modules are identified by a module path in the first line of the `go.mod` file

## Module Creation

A module can be created via

```go
go mod init <module-name>
```

## Module Inspection

To see the modules in a project or workspace

```go
go list -m all
```

## Add Module

To add a module into a project

```go
go get <module-name>
```
