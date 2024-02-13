# JSON

[Go Blog: JSON](https://go.dev/blog/json)

JSON (JavaScript Object Notation) is a simple and widely use data interchange
form

Because it is most commonly use for exchanging data between web back-ends and
JavaScript programs running in the browser, Go has a `json` package in the
standard library

## Encode

A value in Go can be encoded

```go
json.Marshall(v any) (data []byte, error)
```

## Decode

A `[]byte` can be decoded into a Go value

```go
json.Unmarshall(data []byte, v any) error
```

Unmarshal parses the JSON-encoded data and stores the result in the value 
pointed to by v. If v is nil or not a pointer, Unmarshal returns an `InvalidUnmarshalError`.

## Decoding Arbitrary Data

The `json` package using `map[string]interace{}` and `[]inteface{}` values to
store arbitrary JSON objects and arrays 

## Reference Types

`Unmarshall` will allocate data for supported reference types (pointers,
slices and maps)

For example,

```go
type FamilyMember struct {
  Name    string
  Age     int
  Parents []string
}

var m FamilyMember
err := json.Unmarshall(b, &m)
```

A struct `m` is allocated when the variable declaration is made. However the
`Parents` field is a `nil` slice upon the declaration of `m`. Since a slice
is a reference type, `Unmarshall` will allocate memory for the slice and then
store the corresponding data during the decoding process.


