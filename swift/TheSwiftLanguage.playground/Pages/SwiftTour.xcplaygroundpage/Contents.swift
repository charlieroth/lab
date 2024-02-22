//: [Previous](@previous)

import Foundation

/*:
 #### Simple Values
 
 `var` is used to create variables
 
 `let` is use to create constants
*/

var variableAnswer = 42
variableAnswer = 420

let constantAnswer = 42

//: Values are never explicitly converted to another type. Explicit conversion is required

let label = "The width is "
let width = 42
let widthLabel = label + String(width)

//: Non-`String` values can be included in other `String` values using *string-interpolation*

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples"
let orangeSummary = "I have \(oranges) oranges"

//: Multi-line strings use `"""`

let quotation = """
    Even though there is whitespace to the left,
    the actual lines aren't indented.
        Expect for this line
    Double quotes (") can appear without being escaped.

    I still have \(apples + oranges) fruit.
    """

/*:
 Arrays and dictionaries are created using `[]`
 
 Access their elements by writing the index or key in brackets
*/

var fruits = ["strawberries", "limes", "tangerines"]
fruits[1] = "grapes"

var occupations = [
    "Malcom": "Captain",
    "Kaylee": "Mechanic"
]
occupations["Jayne"] = "Public Relations"

//: Arrays automatically grow as you add elements

fruits.append("blueberries")

/*:
 #### Control Flow
 
 Use `if` and `switch` to make conditionals
 
 Use `for-in`, `while` and `repeat-while` to make loops
 */

let individualScores = [75, 43, 103, 87, 12]
var teamScore = 0
for score in individualScores {
    if score > 50 {
        teamScore += 3
    } else {
        teamScore += 1
    }
}

/*:
 `if` and `switch`, in addition to being statements, are also expressions that
 are able to return values based on the result of the conditional
 */

let scoreDecoration = if teamScore > 10 {
    "🎉"
} else {
    ""
}

print("Score:", teamScore, scoreDecoration)

//: Use `if` and `let` to work with optional values

var optionalName: String? = "John Appleseed"
var greeting = "Hello!"
if let name = optionalName {
    greeting = "Hello, \(name)"
}

//: `switch` supports any data type capable of comparison operators

let vegetable = "red pepper"
switch vegetable {
case "celery":
    print("Add some raisins and make ants on a log.")
case "cucumber", "watercress":
    print("That would make a good tea sandwich.")
case let x where x.hasSuffix("pepper"):
    print("Is it a spicy \(x)?")
default:
    print("Everything tastes good in soup.")
}

print(greeting)

//: `for-in` loops can be used to iterate over key-value pairs of a dictionary

let interestingNumbers = [
    "Prime": [2, 3, 5, 7, 11, 13],
    "Fibonacci": [1, 1, 2, 3, 5, 8],
    "Square": [1, 4, 9, 16, 25],
]
var largest = 0
for (_, numbers) in interestingNumbers {
    for number in numbers {
        if number > largest {
            largest = number
        }
    }
}
print(largest)

var largestNumber = 0
var largestNumberKind = ""
for (kind, numbers) in interestingNumbers {
    for number in numbers {
        if number > largestNumber {
            largestNumber = number
            largestNumberKind = kind
        }
    }
}
print("The largest \(largestNumberKind) is \(largestNumber)")

//: Use `..<` to make a range that omits its upper value, and use `...` to make a range that includes both values.

var total = 0
for i in 0..<4 {
    total += i
}
print(total)

total = 0
for i in 0...4 {
    total += i
}
print(total)

/*:
 #### Functions & Closures
 
 Use `func` to declare a function
 
 Use `->` to separate the parameter names and types from the function's return type
 */

func greet(person: String, day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet(person: "Bob", day: "Tuesday")

//: Functions use their parameter names as labels for arguments. Write custom argument labels before parameter name, or write `_` to use no argument label

func greet(_ person: String, on day: String) -> String {
    return "Hello \(person), today is \(day)."
}
greet("John", on: "Wednesday")

//: Functions support multiple return values via Tuples

func calculateStatistics(scores: [Int]) -> (min: Int, max: Int, sum: Int) {
    var min = scores[0]
    var max = scores[0]
    var sum = 0

    for score in scores {
        if score > max {
            max = score
        } else if score < min {
            min = score
        }
        sum += score
    }

    return (min, max, sum)
}
let statistics = calculateStatistics(scores: [5, 3, 100, 3, 9])
print(statistics.sum)
print(statistics.2)

//: You can write a closure without a name by surrounding code with braces `{}`. Use `in` to separate the arguments and return type from the body.

var numbers = [1, 2, 3, 4, 5]
var mappedNumbers = numbers.map({ (number: Int) -> Int in
    let result = 3 * number
    return result
})
print(mappedNumbers)

// More concise version of closure syntax, `$0` refers to the first argument in the closure
mappedNumbers = numbers.map({ number in 3 * number })
print(mappedNumbers)

// Event more concise version of closure syntax, `$0` refers to the first argument in the closure
mappedNumbers = numbers.map { 3 * $0 }
print(mappedNumbers)

/*:
 #### Objects and Classes
 
 Use `class` followed by the class's name to create a class
 
 Class property declarations are written the same as a constant or variable declaration
 
 Method and function declarations are written in the same way
 */

class Shape {
    var numberOfSides = 0
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}

var shape = Shape()
shape.numberOfSides = 7
var shapeDescription = shape.simpleDescription()

//: Class initializers are created with the `init` method

class NamedShape {
    var name: String
    var numberOfSides: Int = 0
    
    init(name: String) {
        self.name = name
    }
    
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}

//: Subclasses

class Square: NamedShape {
    var sideLength: Double
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescription() -> String {
        return "A square with sides of length \(sideLength)"
    }
}

let square = Square(sideLength: 5.2, name: "my test square")
square.area()
square.simpleDescription()

class Cirlce: NamedShape {
    var radius: Double
    
    init(radius: Double, name: String) {
        self.radius = radius
        super.init(name: name)
    }
    
    func area() -> Double {
        return Double.pi * (radius * radius)
    }
    
    override func simpleDescription() -> String {
        return "A circle with sides of radius \(radius)"
    }
}

let circle = Cirlce(radius: 5.2, name: "my test circle")
circle.area()
circle.simpleDescription()

//: Class properties can have a getter and a setter

class EquilateralTriangle: NamedShape {
    var sideLength: Double = 0.0
    
    init(sideLength: Double, name: String) {
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter: Double {
        get {
            return 3.0 * sideLength
        }
        set {
            sideLength = newValue / 3.0
        }
    }
    
    override func simpleDescription() -> String {
        return "A equilateral triangle with sides of length \(sideLength)"
    }
}

let triangle = EquilateralTriangle(sideLength: 3.1, name: "a triangle")
print(triangle.perimeter)

print(triangle.sideLength)
triangle.perimeter = 9.9
print(triangle.sideLength)

/*:
 #### Enumerations
 
 Use `enum` to create an enumeration
 
 Enumerations can have methods associated with them
 
 By default enumeration raw values start at 0, incrementing by one each time. This can be changed by explicitly specifying values
 */

enum Rank: Int, CaseIterable {
    case ace = 1
    case two, three, four, five, six, seven, eight, nine, ten
    case jack, queen, king
    
    func simpleDescription() -> String {
        switch self {
        case .ace:
            return "ace"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
}

let ace = Rank.ace
let aceRawValue = ace.rawValue

enum Suit: CaseIterable {
    case spades, hearts, diamonds, clubs


    func simpleDescription() -> String {
        switch self {
        case .spades:
            return "spades"
        case .hearts:
            return "hearts"
        case .diamonds:
            return "diamonds"
        case .clubs:
            return "clubs"
        }
    }
}
let hearts = Suit.hearts
let heartsDescription = hearts.simpleDescription()

//: Use `init(rawValue:)` initializer to make an instance of an enumeration from a raw value

if let convertedRank = Rank(rawValue: 3) {
    let threeDescription = convertedRank.simpleDescription()
}

//: Enumeration cases can have values associated with cases. These behave like stored properties of each instance of an enumeration case

enum ServerResponse {
    case result(String, String)
    case failure(String)
}

let success = ServerResponse.result("06:00", "20:09")
let failure = ServerResponse.failure("Out of cheese.")

switch success {
case let .result(sunrise, sunset):
    print("Sunrise at \(sunrise), sunset at \(sunset)")
case let .failure(msg):
    print("Failure... \(msg)")
}

/*:
 #### Structures
 
 Use `struct` to create a structure
 
 Structures support many of the same behaviors as classes, including methods and initializers
 
 The most important difference between structures and classes is that structures are always
 copied when they're passed around in your code, but classes are passed by reference
 */

struct Card {
    var rank: Rank
    var suit: Suit
    
    func simpleDescription() -> String {
        return "The \(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
}

let threeOfSpades = Card(rank: .three, suit: .spades)
let threeOfSpadesDescription = threeOfSpades.simpleDescription()

/*:
 Experiment: Write a function that returns an array containing a full deck of cards, with one card of
 each combination of rank and suit
 
 This can be accomplished by adding the `CaseIterable` protocol to the `Rank` and `Suit` enumerations,
 allowing the case values to be iterated on with `for-in`
 */

func deckOfCards() -> [Card] {
    var cards: [Card] = []
    
    for suit in Suit.allCases {
        for rank in Rank.allCases {
            cards.append(Card(rank: rank, suit: suit))
        }
    }
    
    return cards
}



let deck = deckOfCards()
print("There are \(deck.count) cards in a deck")

/*:
 #### Concurrency
 
 Swift supports `async`/`await` structured concurrency
 
 Swift also supports `actor` based concurrency
 */

//: Use `async` to mark a function that runs asynchronously

func fetchUserID(from server: String) async -> Int {
    if server == "primary" {
        return 97
    }
    
    return 501
}

//: Mark a call to an asynchronous function by writing `await` in front of it

func fetchUsername(from server: String) async -> String {
    let userID = await fetchUserID(from: server)
    if userID == 501 {
        return "John Appleseed"
    }
    
    return "Guest"
}

//: Use `async let` to call an asynchronous function, letting it run in parallel without asynchronous code. When you use the value it returns, write `await`

func connectUser(to server: String) async {
    async let userID = fetchUserID(from: server)
    async let username = fetchUsername(from: server)
    let greeting = await "Hello \(username), userID \(userID)"
    print(greeting)
}

//: Use `Task` to call asynchronous function from synchronous code, without waiting for them to return

Task {
    await connectUser(to: "primary")
}

//: Use task groups to structure concurrent code

Task {
    let userIDs = await withTaskGroup(of: Int.self) { group in
        for server in ["primary", "secondary", "development"] {
            group.addTask {
                return await fetchUserID(from: server)
            }
        }
        
        var results: [Int] = []
        for await result in group {
            results.append(result)
        }
        return results
    }
    
    print(userIDs)
}

//: Actors are similar to classes, except they ensure that different asynchronous functions can safely interact with an instance of the same actor as the same time

actor ServerConnection {
    var server: String = "primary"
    private var activeUsers: [Int] = []
    
    func connect() async -> Int {
        let userID = await fetchUserID(from: server)
        // ... communicate with server ...
        activeUsers.append(userID)
        return userID
    }
}

//: When you call a method on an actor or access one of its properties, you mark that code with `await` to indicate that it might have to wait for other code that's already running on the actor to finish

Task {
    let server = ServerConnection()
    let userID = await server.connect()
    print("Server connection userID: \(userID)")
}

/*:
 #### Protocols and Extensions
 
 Classes, enumerations and structures can all adopt protocols
 
 Use `extension` to add functionality to an existing type, such as new methods and computed properties
 
 Extensions can be use to add protocol conformance to a type that's declared elsewhere or even to a
 type imported from a library or framework
 */

//: Use `protocol` to declare a protocol

protocol ExampleProtocol {
    var simpleDescription: String { get }
    mutating func adjust()
}

class SimpleClass: ExampleProtocol {
    var simpleDescription: String = "A very simple class"
    var anotherProperty: Int = 420
    func adjust() {
        simpleDescription += " Now 100% adjusted"
    }
}

var a = SimpleClass()
a.adjust()
let aDescription = a.simpleDescription

struct SimpleStructure: ExampleProtocol {
    var simpleDescription: String = "A simple structure"
    
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }
}

var b = SimpleStructure()
b.adjust()
let bDescription = b.simpleDescription

//: TODO: https://docs.swift.org/swift-book/documentation/the-swift-programming-language/guidedtour/#Error-Handling



//: [Next](@next)
