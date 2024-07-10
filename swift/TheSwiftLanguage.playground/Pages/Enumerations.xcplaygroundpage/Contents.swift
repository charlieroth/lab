//: [Previous](@previous)

import Foundation

/*:
 ## Recursive Enumerations
 
 A *recursive enumeration* is an enumeration that has another instance of the enumeration
 as the associated value for one or more of the enumeration cases. You can indicate an
 enumeration case is recursive by writing `indirect` before it. You can also write `indirect`
 at the beginning of the enumeration declaration to enable indirection for all of the
 enumeration's cases that have an associated value
 */
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

print(evaluate(product))

//: [Next](@next)
