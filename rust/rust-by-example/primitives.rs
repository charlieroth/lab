use std::mem;

fn analyze_slice(slice: &[i32]) {
    println!("First element of slice: {}", slice[0]);
    println!("The slice has {} elements", slice.len());
}

fn reverse(pair: (i32, bool)) -> (bool, i32) {
    let (int_param, bool_param) = pair;
    return (bool_param, int_param);
}

#[derive(Debug)]
struct Matrix(f32, f32, f32, f32);

fn main() {
    // Variables can be type annotated
    let logical: bool = true;
    let a_float: f64 = 1.0; // Regular annotation
    let an_integer = 5i32; // Suffix annotation

    // Default values will be used if not annotated
    let default_float = 3.0; // `f64`
    let default_integer = 7; // `i64`

    // Type can be inferred from context
    let mut inferred_type = 12;
    inferred_type = 4294967296i64;

    // Mutable variable's value can be changed
    let mut mutable = 12;
    mutable = 21;

    // Error! type of a variable cannot be changed
    // mutable = true;

    // Variables can be overwritten with shadowing
    let mutable = true;

    // === Tuples ===
    // Tuples can contain different types
    let long_tuple = (1u8, 2u16, -1i8, 'a', true);

    // Values can be extracted from a tuple with tuple indexing
    println!("Long tuple first value: {}", long_tuple.0);
    println!("Long tuple second value: {}", long_tuple.1);

    let pair = (1, true);
    println!("Reversed pair: {:?}", reverse(pair));

    // Tuples can be destructured to create bindings
    let tuple = (1, "Hello", 4.5, true);
    let (a, b, c, d) = tuple;

    let matrix = Matrix(1.1, 2.2, 3.3, 4.4);
    println!("{:?}", matrix);

    // === Arrays and Slices ===
    // Fixed-size array (type signature is superfluous)
    let xs: [i32; 5] = [1, 2, 3, 4, 5];

    // All elements can be initialized to the same value
    let ys: [i32; 500] = [0; 500];

    println!("Number of elements in array: {}", xs.len());

    // Arrays are stack allocated
    println!("Array occupies {} bytes", mem::size_of_val(&xs));

    // Arrays can be automatically borrowed as slices
    println!("Borrow the whole array as a slice.");
    analyze_slice(&xs);

    // Slices can point to a section of an array
    println!("Borrow a section of the array as a slice");
    analyze_slice(&ys[1..4]);

    // Empty slice `&[]`
    let empty_array: [u32; 0] = [];
    assert_eq!(&empty_array, &[]);

    // Arrays can be safely accessed using `.get()`, which returns
    // an `Option`. This can be matched or used with `.expect()`
    //
    // Purposely iterate one element too far
    for i in 0..xs.len() + 1 {
        match xs.get(i) {
            Some(xval) => println!("{}: {}", i, xval),
            None => println!("Slow down! {} is too far!", i),
        }
    }

    // Out of bound indexing on array causes compile time error
    // println!("{}", xs[5]);
    // Out of bound indexing on slices causes runtime error
    // println!("{}", xs[..][5]);
}
