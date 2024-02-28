//: [Previous](@previous)

import Foundation

/*:
 # Collections
 
 Swift provides three *collection types*:
 
 - Arrays: ordered collections of values
 - Sets: unordered collections of unique values
 - Dictionaries: unordered collections of key-value stores
 
 Swift's collection types are implemented as *generic collections*
 
 ## Mutability of Collections
 
 If you create a collection type and assign it to a variable, the collection
 will be *mutable*
 
 If you create a collection type and assign it to a constant, the collection
 will be *immutable*, and its size and contents can't change
 */

/*:
 ## Arrays
 */

//: Creating an Array with a Default Value

var threeDoubles = Array(repeating: 0.0, count: 3)

//: Creating an Array by Adding Two Arrays Together

var anotherThreeDoubles = Array(repeating: 2.5, count: 3)
var sixDoubles = threeDoubles + anotherThreeDoubles

//: Accessing and Modifying an Array

var shoppingList = ["Eggs", "Milk"]

shoppingList.append("Apples")

shoppingList += ["Baking Powder"]
shoppingList += ["Chocolate Spread", "Cheese", "Butter"]

shoppingList[4...6] = ["Bananas", "Apples"]

shoppingList.insert("Maple Syrup", at: 0)

let mapleSyrup = shoppingList.remove(at: 0)

let apples = shoppingList.removeLast()

//: Array Iteration

shoppingList = ["Eggs", "Milk", "Chocolate Spread", "Cheese", "Butter"]

for item in shoppingList {
    print(item)
}

for (index, value) in shoppingList.enumerated() {
    print("Item \(index + 1): \(value)")
}

/*:
 ## Sets
 
 A type must be hashable in order to be stored in a set — that is, the type must
 provide a way to compute a hash value for itself.
 
 All of Swift’s basic types (such as `String`, `Int`, `Double`, and `Bool`) are
 hashable by default
 
 Enumeration case values without associated values (as described in
 Enumerations) are also hashable by default.
 */

var letters = Set<Character>()
print("letters is of type Set<Character> with \(letters.count) items.")

letters.insert("a")
// letters now contains 1 value of type Character

letters = []
// letters is now an empty set, but is still of type Set<Character>

//: Creating a Set with an Array Literal

var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
//var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]
// favoriteGenres has been initialized with three initial items

//: Accessing and Modifying a Set

print("I have \(favoriteGenres.count) favorite music genres.")

favoriteGenres.insert("Jazz")
// favoriteGenres now contains 4 items

if let removedGenre = favoriteGenres.remove("Rock") {
    print("\(removedGenre)? I'm over it.")
} else {
    print("I never much cared for that.")
}
// Prints "Rock? I'm over it."

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot.")
} else {
    print("It's too funky in here.")
}
// Prints "It's too funky in here."

//: Iterating Over a Set

for genre in favoriteGenres {
    print("\(genre)")
}
// Classical
// Jazz
// Hip hop

for genre in favoriteGenres.sorted() {
    print("\(genre)")
}
// Classical
// Hip hop
// Jazz

/*:
 ## Set Operations
 
 - Use the `intersection(_:)` method to create a new set with only the values 
   common to both sets.
 
 - Use the `symmetricDifference(_:)` method to create a new set with values in
   either set, but not both.
 
 - Use the `union(_:)` method to create a new set with all of the values in both
   sets.
 
 - Use the `subtracting(_:)` method to create a new set with values not in the
   specified set.
 */

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumbers: Set = [2, 3, 5, 7]

oddDigits.union(evenDigits).sorted()
// [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

oddDigits.intersection(evenDigits).sorted()
// []

oddDigits.subtracting(singleDigitPrimeNumbers).sorted()
// [1, 9]

oddDigits.symmetricDifference(singleDigitPrimeNumbers).sorted()
// [1, 2, 9]

//: [Next](@next)
