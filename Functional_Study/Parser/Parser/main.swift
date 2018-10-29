//
//  main.swift
//  Parser
//
//  Created by 伯驹 黄 on 2017/4/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

struct Parser<Result> {
    typealias Stream = String.CharacterView
    let parse: (Stream) -> (Result, Stream)?
}

func character(condition: @escaping (Character) -> Bool) -> Parser<Character> { return Parser { input in
    guard let char = input.first , condition(char) else { return nil }
    return (char, input.dropFirst())
    }
}

extension Parser {
    func run(_ string: String) -> (Result, String)? {
        guard let (result, remainder) = parse(string.characters) else { return nil }
        return (result, String(remainder))
    }
}

extension CharacterSet {
    func contains(_ c: Character) -> Bool {
        let scalars = String(c).unicodeScalars
        guard scalars.count == 1 else { return false }
        return contains(scalars.first!)
    }
}

extension Parser {
    var many: Parser<[Result]> {
        return Parser<[Result]> { input in
            var result: [Result] = []
            var remainder = input
            while let (element, newRemainder) = self.parse(remainder) {
                result.append(element)
                remainder = newRemainder
            }
            return (result, remainder)
        }
    }
}

extension Parser {
    func map<T>(_ transform: @escaping (Result) -> T) -> Parser<T> {
        return Parser<T> { input in
            guard let (result, remainder) = self.parse(input) else { return nil }
            return (transform(result), remainder)
        }
    }
}

extension Parser {
    func followed<A>(by other: Parser<A>) -> Parser<(Result, A)> {
        return Parser<(Result, A)> { input in
            guard let (result1, remainder1) = self.parse(input) else { return nil }
            guard let (result2, remainder2) = other.parse(remainder1) else { return nil }
            return ((result1, result2), remainder2)
        }
    }
}

func multiply(lhs: (Int, Character), rhs: Int) -> Int {
    return lhs.0 * rhs
}


func curriedMultiply(_ x: Int) -> (Character) -> (Int) -> Int {
    return { op in return { y in return x * y } }
}

let one = character { $0 == "1" }
print(one.parse("123".characters) as Any)

let digit = character { CharacterSet.decimalDigits.contains($0) }
print(digit.run("456"))

print(digit.many.run("123"))

let integer = digit.many.map { Int(String($0))! }
print(integer.run("123"))

let multiplication = integer.followed(by: character { $0 == "*" }).followed(by: integer)
print(multiplication.run("2*3"))




let p1 = integer.map(curriedMultiply)
let p2 = p1.followed(by: character { $0 == "*" })
let p3 = p2.map { f, op in f(op) }
let p4 = p3.followed(by: integer)
let p5 = p4.map {f, y in f(y) }

print(p5.run("2*3"))

let multiplication3 = integer.map(curriedMultiply)
    .followed(by: character { $0 == "*" }).map { f, op in f(op) }.followed(by: integer).map { f, y in f(y) }


precedencegroup SequencePrecedence {
    associativity: left
    higherThan: AdditionPrecedence
}


infix operator<*>:SequencePrecedence
func <*> <A, B>(lhs: Parser<(A) -> B>, rhs: Parser<A>) -> Parser<B> {
    return lhs.followed(by: rhs).map { f, x in f(x) }
}


infix operator<^>: SequencePrecedence
func <^> <A, B>(lhs: @escaping (A) -> B, rhs: Parser<A>) -> Parser<B> {
    return rhs.map(lhs)
}


let multiplication4 =
    integer.map(curriedMultiply) <*> character { $0 == "*" } <*> integer


let multiplication5 =
    curriedMultiply <^> integer <*> character { $0 == "*" } <*> integer

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return{ a in { b in f(a, b) } }
}

infix operator *>: SequencePrecedence
func *><A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<B> {
    return curry({ _, y in y }) <^> lhs <*> rhs
}

infix operator <*: SequencePrecedence
func <* <A, B>(lhs: Parser<A>, rhs: Parser<B>) -> Parser<A> {
    return curry({ x, _ in x }) <^> lhs <*> rhs
}

extension Parser {
    func or(_ other: Parser<Result>) -> Parser<Result> {
        return Parser<Result> { input in
            return self.parse(input) ?? other.parse(input)
        }
    }
}
let star = character { $0 == "*" }


let plus = character { $0 == "+" }
let starOrPlus = star.or(plus)
print(starOrPlus.run("+"))


infix operator<|>
func <|><A>(lhs: Parser<A>, rhs: Parser<A>) -> Parser<A> {
    return lhs.or(rhs)
}

(star <|> plus).run("+")

extension Parser {
    var many1: Parser<[Result]> {
        return { x in { manyX in [x] + manyX } } <^> self <*> self.many
    }
}

extension Parser {
    var optional: Parser<Result?> {
        return Parser<Result?> { input in
            guard let (result , remainder) = self.parse(input) else { return (nil , input) }
            return (result, remainder)
        }
    }
}

let division = curry({ $0 / ($1 ?? 1) }) <^>
    multiplication <*> (character { $0 == "/" } *> multiplication).optional

let addition = curry({ $0 + ($1 ?? 0) }) <^>
    division <*> ( character { $0 == "+" } *> division ).optional

let minus = curry({ $0 - ($1 ?? 0) }) <^>
    addition <*> (character { $0 == "-" } *> addition).optional

let expression = minus

expression.run("2*3+4*6/2-10")
