// Rust custom data types are formed mainly through the two keywords:
// - `struct`: define a structure
// - `enum`: define an enumeration
//
// Constants can also be created via the `const` and `static` keywords`

// Attribute to hide warnings for unused code
#![allow(dead_code, unused_variables)]

#[derive(Debug)]
struct Person {
    name: String,
    age: u8,
}

// Unit struct
struct Unit;

// A tuple struct
struct Pair(i32, f32);

// Struct with two fields
struct Point {
    x: f32,
    y: f32,
}

// Structs can be reused as fields of another struct
struct Rectangle {
    top_left: Point,
    bottom_right: Point,
}

enum WebEvent {
    // An `enum` variant may be either a `unit-like`,
    PageLoad,
    PageUnload,
    // like tuple structs
    KeyPress(char),
    Paste(String),
    // c-like structure
    Click { x: i64, y: i64 },
}

enum VeryVerboseEnumOfThingsToDoWithNumbers {
    Add,
    Subtract,
}

// A common place for type aliases is in `impl` blocks
// where there is a `Self` alias referring to the type
// you are implementing additional functionality for
impl VeryVerboseEnumOfThingsToDoWithNumbers {
    fn run(&self, x: i32, y: i32) -> i32 {
        match self {
            Self::Add => x + y,
            Self::Subtract => x - y,
        }
    }
}

// Creates a type alias
type Operations = VeryVerboseEnumOfThingsToDoWithNumbers;

fn inspect(event: WebEvent) {
    match event {
        WebEvent::PageLoad => println!("page loaded"),
        WebEvent::PageUnload => println!("page unloaded"),
        WebEvent::KeyPress(c) => println!("pressed {}", c),
        WebEvent::Paste(s) => println!("pasted {}", s),
        WebEvent::Click { x, y } => println!("clicked at x={}, y={}", x, y),
    }
}

// Rust has two different types of constants which can be declared in
// any scope including global. Both require explicit type annotation.
//
// - `const`: An unchangable value
// - `static`: A possibly mutable variable with  `'static` lifetime. The static
//   lifetime is inferred and does not have to be specified. Accessing or modifying
//   a mutable static variable is `unsafe`
static LANGUAGE: &str = "Rust";
const THRESHOLD: i32 = 10;

fn is_big(n: i32) -> bool {
    return n > THRESHOLD;
}

fn main() {
    // === Structures ===
    let name = String::from("Charlie");
    let age = 28;
    let charlie = Person { name, age };
    println!("{:?}", charlie);

    let point: Point = Point { x: 10.3, y: 0.4 };
    let another_point: Point = Point { x: 5.2, y: 0.2 };
    println!("point coordinates: ({}, {})", point.x, point.y);

    // Make a new point using struct update syntax
    let bottom_right = Point {
        x: 5.2,
        ..another_point
    };
    println!("second point : ({}, {})", bottom_right.x, bottom_right.y);

    // Destructure the point using a `let` binding
    let Point {
        x: left_edge,
        y: top_edge,
    } = point;
    let _rectangle = Rectangle {
        top_left: Point {
            x: left_edge,
            y: top_edge,
        },
        bottom_right: bottom_right,
    };

    // Instantiate a unit struct
    let _unit = Unit;

    // Instantiate a tuple struct
    let pair = Pair(1, 0.1);
    println!("pair contains {:?} and {:?}", pair.0, pair.1);

    // === Enumerations ===
    let pressed = WebEvent::KeyPress('x');
    // `to_owned()` creates an owned `String` from a string slice.
    let pasted = WebEvent::Paste("my text".to_owned());
    let click = WebEvent::Click { x: 20, y: 80 };
    let load = WebEvent::PageLoad;
    let unload = WebEvent::PageUnload;

    inspect(pressed);
    inspect(pasted);
    inspect(click);
    inspect(load);
    inspect(unload);

    let x = Operations::Add;

    // === Constants ===
    let n = 16;
    println!("This is {}", LANGUAGE);
    println!("The threshold is {}", THRESHOLD);
    println!("{} is {}", n, if is_big(n) { "big" } else { "small" });
}
