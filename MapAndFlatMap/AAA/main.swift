//
//  main.swift
//  AAA
//
//  Created by 伯驹 黄 on 16/8/3.
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Foundation

let arr = [1, 2, 4, 5, 9]

let str = arr.reduce("") {
    print("$0=\($0)", "$1=\($1)")
    return $0 + ($0.isEmpty ? "" : ",") + $1.description
}

print(str)
// $0为返回值
// $1为数组中的元素

/*
 $0= $1=1
 $0=1 $1=2
 $0=1,2 $1=4
 $0=1,2,4 $1=5
 $0=1,2,4,5 $1=9
 */

// http://test.cmcaifu.com/api/v2/products/?period_0=0&period_1=15

let url = "http://test.cmcaifu.com/api/v2/products/?period_0=0&period_1=15&type=1001"
let arrs = url.components(separatedBy: "?")
if let query = arrs.last {
    let queries = query.components(separatedBy: "&")
    let aa = queries.filter({ !$0.contains("type") })
    print(aa)
}

let dict = ["period_0": "1", "period_1": "20", "type": "a"]
let newUrl = dict.reduce("?") {
    return $0 + ($0 == "?" ? "" : "&") + "\($1.0)=\($1.1)"
}

print(newUrl)

func addFactory(_ addValue: Int) -> ((Int) -> Int) {
    return { addValue + $0 }
}

func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incrementByTen = makeIncrementor(forIncrement: 10)
print(incrementByTen())

typealias IntFunction = (Int) -> Int
func funcBuild(_ f: @escaping IntFunction, _ g: @escaping IntFunction)
    -> IntFunction {
    return {
        f(g($0))
    }
}

let f1 = funcBuild({ $0 + 2 }, { $0 + 3 })
print(f1(0)) // 得到 5
let f2 = funcBuild({ $0 * 2 }, { $0 * 5 })
print(f2(1)) // 得到 10

func funcBuild1<T, U, V>(_ f: @escaping (T) -> U, _ g: @escaping (V) -> T)
    -> (V) -> U {
    return {
        f(g($0))
    }
}
let f3 = funcBuild1({ "No." + String($0) }, { $0 * 2 })
print(f3(23))

func memoize<T: Hashable, U>(_ body: @escaping (T) -> U) -> ((T) -> U) {
    var memo = Dictionary<T, U>()
    return { x in
        if let q = memo[x] { return q }
        let r = body(x)
        memo[x] = r
        return r
    }
}

var factorial: (Int) -> Int = { $0 }
factorial = memoize { x in x == 0 ? 1 : x * factorial(x - 1) }
print(factorial)

func getClock() -> () -> Int {
    var count = 0
    let getCount = { () -> Int in
        count += 1
        return count
    }
    return getCount
}

let c1 = getClock()
print("getClock=\(c1())") // 得到 1
print("getClock=\(c1())") // 得到 2

let res = arr.first.flatMap { arr.reduce($0, max) }
print("res=\(res)")

let trr = arr.map { "No." + $0.description }

// MARK: - FUNCTOR

func add(x: Int) -> (Int) -> Int {
    return { $0 + x }
}

let addOne = add(x: 1)
print("addOne=\(addOne(2))")

func addTow(_ x: Int, y: Int) -> Int {
    return x + 2 + y
}

func curry<A, B, C>(_ f: @escaping (A, B) -> C) -> (A) -> (B) -> C {
    return { a in { b in f(a, b) } }
}
let curring = curry(addTow)
print("curring=\(curring)")
let result = curring(5)
print("result=\(result)")
let result1 = result(6)
print("result1=\(result1)")

func printEach<T: Sequence>(_ items: T) {
    for item in items {
        print(item)
    }
}
printEach(1 ..< 5)

var xs = [1, 5, 2, 4, 3]
xs.sort(by: <)
print(xs)

enum MyApi {
    case xAuth(String, String)
    case getUser(Int)
}

let number = Optional(815)

let transformedNumber = number.map { $0 * 2 }.map { $0 % 2 == 0 }

func add1(a: Int) -> ((Int) -> Int) {

    return { b in
        a + b
    }
}

let numbers = 1 ... 10
let added = numbers.map(add1(a: 2))
print(added)

struct City {
    let name: String, population: Int
}

let paris = City(name: "Paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)
let cities = [paris, madrid, amsterdam, berlin]

extension City {
    func cityByScalingPopulation() -> City {
        return City(name: name, population: population * 1000)
    }
}

let newStr = cities.filter { $0.population > 1000 }
    .map { $0.cityByScalingPopulation() }
    .reduce("City: Population") { result, c in
        result + "\n" + "\(c.name): \(c.population)" }
print(newStr)

func add(_ a: Int) -> (Int) -> Int {
    var n = a
    return {
        n += $0
        return n
    }
}

let a = add(5)

print(a(10))

print(a(10))

print(a(10))

func method<T>(a: T, f: @escaping (_ x: T, _ y: T) -> T) -> (T) -> T {
    return { b in f(a, b) }
}

func sum(a: Int, b: Int) -> Int {
    return a + b
}

func mul(a: Double, b: Double) -> Double {
    return a * b
}

let m = method(a: 5, f: mul)
let n = m(10)
print(n)

extension Array {
    func reduce<T>(_ initial: T, combine: (T, Element) -> T) -> T {
        var result = initial
        for x in self {
            result = combine(result, x)
        }
        return result
    }
}

class IntegerRef: NSObject {
    let int: Int
    init(_ int: Int) {
        self.int = int
    }
}

func ==(lhs: IntegerRef, rhs: IntegerRef) -> Bool {
    return lhs.int == rhs.int
}

let one = IntegerRef(1)
let otherOne = IntegerRef(1)
print(one == otherOne) // true

let two: NSObject = IntegerRef(2)
let otherTwo: NSObject = IntegerRef(2)
print(two == otherTwo) // false
