// All types which want to use `std::fmt` formatting
// traits require an implementation to be printable
//
// The `fmt::Debug` trait makes this very straightforward
// All types can `derive` the `fmt::Debug` trait

// This structure cannot be printed either with `fmt::Display`
// or with `fmt::Debug`
struct UnPrintable(i32);

// The `derive` attribute automatically creates the implementation
// required to makes this `struct` printable with `fmt::Debug`
#[derive(Debug)]
struct DebugPrintable(i32);

// All `std` library types are automatically printable with `{:?}` too:
#[derive(Debug)]
struct Structure(i32);

#[derive(Debug)]
struct Deep(Structure);

// `fmt::Debug` makes this structure more printable but sacrafices some elegance
// Pretty printing can be done with `{:#?}`
#[derive(Debug)]
struct Person<'a> {
    name: &'a str,
    age: u8
}

fn main() {
    println!("{:?} months in a year.", 12);
    println!("{1:?} {0:?} is the {actor:?} name.", "Slater", "Christian", actor="actor's");
    println!("Now {:?} will print!", Structure(3));
    // The problem with `derive` is there is no control over how the results look.
    // What if I want this to just show a `7`
    println!("Now {:?} will print!", Deep(Structure(7)));

    let name = "Charlie";
    let age = 28;
    let charlie = Person {name, age};
    println!("{:#?}", charlie);
}
