//
//  main.swift
//  StartWithProtocol
//
//  Created by 伯驹 黄 on 2016/10/18.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

// let numberOfIterations = 10
//
// protocol Ordered {
//    func precedes(other: Self) -> Bool
// }
//
// struct Number: Ordered {
//    var vaule: Double = 0
//
//    func precedes(other: Number) -> Bool {
//        return self.vaule < other.vaule
//    }
// }
//
//
//
// protocol Arbitrary: Smaller {
//    static func arbitrary() -> Self
// }
//
// protocol Smaller {
//    func smaller() -> Self?
// }
//
// extension Int: Arbitrary {
//    static func arbitrary() -> Int {
//        return Int(arc4random())
//    }
// }
//
// extension Character: Arbitrary {
//    func smaller() -> Character? {
//        return nil
//    }
//
//    static func arbitrary() -> Character {
//        return Character(UnicodeScalar(Int.random(from: 65, to: 90))!)
//    }
// }
//
// extension Int: Smaller {
//
//    func smaller() -> Int? {
//        return self == 0 ? nil : self / 2
//    }
//
//    static func random(from: Int, to: Int) -> Int {
//        return from + (Int(arc4random()) % (to - from)) }
// }
//
// func tabulate<A>(_ times: Int, transform: (Int) -> A) -> [A] {
//    return (0..<times).map(transform)
// }
//
// extension String: Arbitrary {
//    static func arbitrary() -> String {
//        let randomLength = Int.random(from: 0, to: 40)
//        let randomCharacters = tabulate(randomLength) { _ in
//            Character.arbitrary() }
//        return String(randomCharacters)
//    }
//
//    func smaller() -> String? {
//        return isEmpty ? nil : String(characters.dropFirst())
//    }
// }
//
//
// func check1<A: Arbitrary>(_ message: String, property: (A)->Bool) -> () {
//    for _ in 0..<numberOfIterations {
//        let value = A.arbitrary()
//        guard property(value) else {
//            print ( " \"\( message)\" doesn't hold: \(value)")
//            return
//        }
//    }
//    print ( " \"\( message)\" passed \(numberOfIterations) tests.")
// }
//
// extension CGSize {
//    var area: CGFloat {
//        return width * height
//    }
// }
//
// extension CGFloat: Arbitrary {
//    func smaller() -> CGFloat? {
//        return nil
//    }
//
//
//    static func arbitrary() -> CGFloat {
//        let random: CGFloat = CGFloat(arc4random())
//        let maxUint = CGFloat(UInt32.max)
//        return 10000 * ((random - maxUint/2) / maxUint)
//    }
// }
//
// extension CGSize: Arbitrary {
//    func smaller() -> CGSize? {
//        return nil
//    }
//
//    static func arbitrary() -> CGSize {
//        return CGSize(width: CGFloat.arbitrary(), height: CGFloat.arbitrary())
//    }
// }
//
//
// check1("Area should be at least 0") { (size: CGSize) in size.area >= 0 }
//
// check1("Every string starts with Hello") { (s: String) in
//    s.hasPrefix("Hello")
// }
//
// print(100.smaller())
//
// func iterateWhile<A>(_ condition: (A) -> Bool, initial : A, next: (A) -> A?) -> A { if let x = next(initial), condition(x) {
//        return iterateWhile(condition, initial : x, next: next)
//    }
//    return initial
// }
//
// func check2<A: Arbitrary>(_ message: String, property: (A) -> Bool) {
//    for _ in 0..<numberOfIterations {
//        let value = A.arbitrary()
//        guard property(value) else {
//            let smallerValue = iterateWhile({ !property($0) }, initial : value) { $0.smaller()
//            }
//            print ( " \"\( message)\" doesn't hold: \(smallerValue)")
//            return
//        } }
//    print ( " \"\( message)\" passed \(numberOfIterations) tests.")
// }
//
// func qsort(_ array: [Int]) -> [Int] {
//    var array = array
//    if array.isEmpty { return [] }
//    let pivot = array.remove(at: 0)
//    let lesser = array.filter { $0 < pivot }
//    let greater = array.filter { $0 >= pivot }
//    let a = qsort(greater)
//    return qsort(lesser) + [pivot] + a
// }
//
// extension Array: Smaller {
//    func smaller() -> [Element]? {
//        guard !isEmpty else { return nil }
//        return Array(dropFirst())
//    }
// }
//
// check2("qsortshouldbehavelikesort"){ (x: [Int]) in
//    return qsort(x) == x.sorted()
// }

enum HTTPMethod: String {
    case GET
    case POST
}

protocol Request {
    var host: String { get }
    var path: String { get }

    var method: HTTPMethod { get }
    var parameter: [String: Any] { get }
}

struct UserRequest: Request {
    let name: String

    var host: String {
        return "https://api.onevcat.com"
    }

    var path: String {
        return "/users/\(name)"
    }

    let method: HTTPMethod = .GET
    let parameter: [String: Any] = [:]
}
