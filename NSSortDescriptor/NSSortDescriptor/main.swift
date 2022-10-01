//
//  main.swift
//  NSSortDescriptor
//
//  Created by 黄伯驹 on 2017/10/1.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import Foundation

final class Person: NSObject {
    @objc var first: String
    @objc var last: String
    @objc var yearOfBirth: Int

    init(first: String, last: String, yearOfBirth: Int) {
        self.first = first
        self.last = last
        self.yearOfBirth = yearOfBirth
    }
}

let people = [
    Person(first: "Jo", last: "Smith", yearOfBirth: 1970),
    Person(first: "Joe", last: "Smith", yearOfBirth: 1970),
    Person(first: "Joe", last: "Smyth", yearOfBirth: 1970),
    Person(first: "Joanne", last: "smith", yearOfBirth: 1985),
    Person(first: "Joanne", last: "smith", yearOfBirth: 1970),
    Person(first: "Robert", last: "Jones", yearOfBirth: 1970),
]

let lastDescriptor = NSSortDescriptor(key: #keyPath(Person.last), ascending: true,
                                      selector: #selector(NSString.localizedCaseInsensitiveCompare))
let  rstDescriptor = NSSortDescriptor(key: #keyPath(Person.first), ascending: true,
                                      selector: #selector(NSString.localizedCaseInsensitiveCompare))
let yearDescriptor = NSSortDescriptor(key:  #keyPath(Person.yearOfBirth), ascending: true)


let descriptors = [lastDescriptor,  rstDescriptor, yearDescriptor]
(people as NSArray).sortedArray(using: descriptors)


let numbers = [
    "一",
    "十三",
    "二",
    "四",
    "六",
    "十一"
]

extension String {
    fileprivate var toInt: Int {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: "zh")
        numberFormatter.numberStyle = .spellOut
        let number = numberFormatter.number(from: self)
        return number?.intValue ?? 0
    }
}

let result = numbers.sorted { (a, b) -> Bool in
    a.toInt < b.toInt
}
print(result)



let swedish = Locale(identifier: "zh")
let sortedTitles = numbers.sorted {
    $0.compare($1, locale: swedish) == .orderedAscending
}

print(sortedTitles)

extension Character {
    var unicodeScalarCodePoint: UInt32 {
        let characterString = String(self)
        let scalars = characterString.unicodeScalars
        
        return scalars[scalars.startIndex].value
    }
}


// ================================================================

typealias SortDescriptor<Value> = (Value, Value) -> Bool

let sortByYear: SortDescriptor<Person> = {
    $0.yearOfBirth < $1.yearOfBirth
}
let sortByLastName: SortDescriptor<Person> = {
    $0.last.localizedCaseInsensitiveCompare($1.last) == .orderedAscending
}

func sortDescriptor<Value, Key>(
    key: @escaping (Value) -> Key,
    _ areInIncreasingOrder: @escaping (Key, Key) -> Bool) -> SortDescriptor<Value> {
    return { areInIncreasingOrder(key($0), key($1)) }
}

let sortByYearAlt: SortDescriptor<Person> = sortDescriptor(key: { $0.yearOfBirth }, <)
people.sorted(by: sortByYearAlt)


func sortDescriptor<Value, Key>(key: @escaping (Value) -> Key) -> SortDescriptor<Value> where Key: Comparable {
    return { key($0) < key($1) }
}

let sortByYearAlt2: SortDescriptor<Person> = sortDescriptor(key: { $0.yearOfBirth })

func sortDescriptor<Value, Key>(
    key: @escaping (Value) -> Key,
    ascending: Bool = true,
    _ comparator: @escaping (Key) -> (Key) -> ComparisonResult) -> SortDescriptor<Value> {
    return { lhs, rhs in
        let order: ComparisonResult = ascending ? .orderedAscending
            : .orderedDescending
        return comparator(key(lhs))(key(rhs)) == order }
}

let sortByFirstName: SortDescriptor<Person> =
    sortDescriptor(key: { $0.first }, String.localizedCaseInsensitiveCompare)
people.sorted(by: sortByFirstName)

func combine<Value>(sortDescriptors: [SortDescriptor<Value>]) -> SortDescriptor<Value> {
    return { lhs, rhs in
        for areInIncreasingOrder in sortDescriptors {
            if areInIncreasingOrder(lhs,rhs) { return true }
            if areInIncreasingOrder(rhs,lhs) { return false }
        }
        return false
    }
}

let combined: SortDescriptor<Person> = combine(sortDescriptors: [sortByLastName, sortByFirstName, sortByYear])
people.sorted(by: combined)


func log(condition: Bool = false,
         message: @autoclosure () -> (String),
         file: String = #file, line function: String = #function, line: Int = #line) {
    if condition { return }
    print("myAssert failed: \(message()), \(file):\(function) (line \(line))")
}
log(message: "This is a test")
