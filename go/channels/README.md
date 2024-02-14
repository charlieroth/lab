# Channels

[Go Tour: Concurrency](https://go.dev/tour/concurrency/2)

[Effective Go: Channels](https://go.dev/doc/effective_go#channels)

Channels are a typed conduit through which you can send and
receive values with the channel operator `<-`

> conduit: a channel for conveying water or other fluid

Channels must be allocated before being used. This is done
with `make(chan int)`.

The creation of a channel can take an optional integer, creating
a buffered channel: `make(chan *os.File, 100)`. The default
value for this optional buffer size if `0`, so an unbuffered
channel can be created either with the syntax mentioned above
or via: `make(chan bool, 0)`.

Receivers always block until there is data to receive

In unbuffered channels, the sender blocks until the receiver has
received the value

In buffered channels, the sender only blocks until the value has
been copied to the buffer; if the buffer is full, this means
waiting until some receiver has retrieved a value.

A buffered channel can be used like a semaphore, for example to
limit throughput

One of the most important properties of Go is that a channel is a 
first-class value that can be allocated and passed around like 
any other. A common use of this property is to implement safe, 
parallel demultiplexing.

The `for range` form can be used to receive values from a channel
until it is closed
