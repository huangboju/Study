//
//  main.swift
//  Mirror
//
//  Created by 伯驹 黄 on 2016/12/26.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

class User {
    var name: String = "" // 姓名
    var nickname: String? // 昵称
    var age: Int? // 年龄
    var emails: [String]? // 邮件地址
}

let user1 = User()
user1.name = "hangge"
user1.age = 100
user1.emails = ["hangge@hangge.com", "system@hangge.com"]

// 将user对象进行反射
let hMirror = Mirror(reflecting: user1)

print("对象类型：\(hMirror.subjectType)")
print("对象子元素个数：\(hMirror.children.count)")

print("--- 对象子元素的属性名和属性值分别如下 ---")
for case let (label?, value) in hMirror.children {
    print("属性：\(label)     值：\(value)")
}

class A<T>: NSObject {
    let a = 10
}

class B: A<String> {
}

print(B().value(forKey: "a"))

// http://andelf.github.io/blog/2014/06/20/swift-reflection/
// http://swift.gg/2015/11/23/swift-reflection-api-what-you-can-do/
// http://nshipster.com/mirrortype/

extension Mirror {

    func toDict(for cls: AnyClass? = nil) -> [String: Any] {
        var dict = [String: Any]()

        // Properties of this instance:
        let method = {
            for attr in self.children {
                if let propertyName = attr.label {
                    dict[propertyName] = attr.value
                }
            }
        }
        if let cls = cls {
            if description.contains("\(cls)") {
                method()
                return dict
            }
        } else {
            method()
        }

        // Add properties of superclass:
        if let parent = superclassMirror {
            for (propertyName, value) in parent.toDict(for: cls) {
                dict[propertyName] = value
            }
        }
        return dict
    }
}

class A1<T>: NSObject {
    var a: [T] = []
    let b = 10
    override func value(forUndefinedKey _: String) -> Any? {
        print("😁")
        return "1111"
    }

    override func value(forKey key: String) -> Any? {
        let v = super.value(forKey: key)
        print(v, "aaaa")
        return v
    }
}

class B1: A1<Int> {

    override init() {
        super.init()
        a = [1, 2, 3]
    }

    let cb = 10
    let y = 5
    let ab = 2
    let cd = 12
}

class C: B1 {
    let arr = "1"
    let brr = "1"
}

let mirr = Mirror(reflecting: C())
print("**********************************************\n\n")
print("C", mirr.toDict(for: C.self), "\n\n")
print("B1", mirr.toDict(for: B1.self), "\n\n")
print("A1", mirr.toDict(for: A1<Int>.self), "\n\n")
print("**********************************************\n\n")

dump(C())

print("\n\n")

class MyClass {

    fileprivate static let aa = 100

    func method() {

        // 这里的a是MyClass的元类型（metatype of MyClass）
        let a = type(of: self)

        // 这里直接通过MyClass的元类型对象a来访问MyClass的类成员aa
        var value = a.aa

        print("The value is: \(value)")

        // 这里的b是Int的类型（metatype of Int）
        let b = type(of: a.aa)

        // 如果要通过一个元类型来创建一个对象实例，那么必须显式地调用该结构体或类的构造方法
        value = b.init(20)
        print("The integer is: \(value)")

        // 一个结构体或类的元类型可以直接用该结构体或类名访问Type属性即可表示。
        // 但这里要注意的是，像这里的Int.Type只能作为对象的类型进行声明，而不能作为一个表达式来使用。
        // 所以，它也不能作为type(of:)函数的实参进行传递
        let c: Int.Type = type(of: type(of: self).aa)
        value = c.init("1234")!
        print("The value is: \(value)")
    }
}

let mc = MyClass()
mc.method()
