mutable struct Value
    data::Float64
    prev::Set{Value}
    op::String
    Value(data::Float64) = new(data,Set(), "")
    Value(data::Float64,prev::Set{Value}) = new(data,prev, "")
    Value(data::Float64,prev::Set{Value},op::String) = new(data,prev,op)
end

function Base.:+(a::Value, b::Value)
    Value(a.data + b.data, Set([a, b]), "+")
end

function Base.:*(a::Value, b::Value)
    Value(a.data * b.data, Set([a, b]), "*")
end

a = Value(2.0)
b = Value(-3.0)
c = Value(10.0)
d = a*b + c
