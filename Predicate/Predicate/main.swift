//
//  main.swift
//  Predicate
//
//  Created by 伯驹 黄 on 16/9/9.
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Foundation

print("Hello, World!")

class Person: NSObject {
    var name: String
    var age: Int
    init(name: String, age: Int) {
        self.name = name
        self.age = age
        super.init()
    }

    override var description: String {
        return "name:\(self.name) age:\(self.age)"
    }
}

let persons = NSMutableArray()
persons.add(Person(name: "Jack Tomphon", age: 23))
persons.add(Person(name: "Mikle Steven", age: 25))
persons.add(Person(name: "Tacmk", age: 24))

let pridicateByAge = NSPredicate(format: "age == 24")
let pridicateByAge2 = NSPredicate(format: "age == %@", NSNumber(value: 24))
let pridicateByAge3 = NSPredicate(format: "%K == %@", "age", NSNumber(value: 24))
let pridicateByAge4 = NSPredicate(format: "age == $age")

let result = persons.filtered(using: pridicateByAge)
let result2 = persons.filtered(using: pridicateByAge2)
let result3 = persons.filtered(using: pridicateByAge3)

let result4 = persons.filtered(using: pridicateByAge4.withSubstitutionVariables(["age": NSNumber(value: 24)]))

print(result, "result")
print(result2, "result2")
print(result3, "result3")
print(result4, "result4")

let dataSource = [
    "Domain CheckService",
    "IMEI check",
    "Compliant about service provider",
    "Compliant about TRA",
    "Enquires",
    "Suggestion",
    "SMS Spam",
    "Poor Coverage",
    "Help Salim",
]
var datas = [Person]()
datas.append(Person(name: "Jack Tomphon", age: 23))
datas.append(Person(name: "Mikle Steven", age: 25))
datas.append(Person(name: "Tacmk", age: 24))
datas.append(Person(name: "Tom Tomphon", age: 23))

let searchString = "Enq"
let predicate = NSPredicate(format: "age == 23")
let searchDataSource = datas.filter { predicate.evaluate(with: $0) }
print(searchDataSource)

let attributeName = "firstName"
let attributeValue = "Adam"

let pre = NSPredicate(format: "%K like %@", attributeName, attributeValue)

print(pre)

let betweenPredicate = NSPredicate(format: "attributeName BETWEEN %@", [1, 10])

let dict = ["attributeName": 5]
let between = betweenPredicate.evaluate(with: dict)
if between {
}
