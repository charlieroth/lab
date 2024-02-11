# Make

`make(T, args)` is a built-in function, different than `new(T)` that can
create slices, maps and channels only, and it returns an initialized
(not zeroed) value of type `T` (not `*T`).

Because slices, maps and channels are types which reference a underlying
data structure, that must be initialized before use, the distinction of "an
initialized (not zeroed) value of type `T` (not `*T`)" is necessary.

With this said, `make(T, args)` is a form of allocation
