//
//  main.swift
//  Currying
//
//  Created by 伯驹 黄 on 2016/10/18.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

func addOne(num: Int) -> Int {
    return 1 + num
}

func addTo(_ adder: Int) -> (Int) -> Int {
    return { num in num + adder }
}

let addTwo = addTo(2)(8)
print(addTwo)

func greaterThan(_ comparer: Int) -> (Int) -> Bool {
    return { $0 > comparer }
}

let greaterThan10 = greaterThan(10)
print(greaterThan10(1))

protocol TargetAction {
    func performAction()
}

struct TargetActionWrapper<T: AnyObject>: TargetAction {
    weak var target: T?
    let action: (T) -> () -> Void
    func performAction() {
        if let t = target {
            action(t)()
        }
    }
}

enum ControlEvent {
    case TouchUpInside, ValueChanged
}

class Control {
    var actions = [ControlEvent: TargetAction]()

    func setTarget<T: AnyObject>(target: T,
                                 action: @escaping (T) -> () -> Void,
                                 controlEvent: ControlEvent) {

        actions[controlEvent] = TargetActionWrapper(
            target: target, action: action)
    }

    func removeTargetForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent] = nil
    }

    func performActionForControlEvent(controlEvent: ControlEvent) {
        actions[controlEvent]?.performAction()
    }
}

func swapMe<T>(a: inout T, b: inout T) {
    (a, b) = (b, a)
}

var a = 3
var b = 5
swapMe(a: &a, b: &b)
print(a, b)

func isNumber(string: String) -> Bool {
    var string = string
    string = string.trimmingCharacters(in: CharacterSet.decimalDigits)
    if string.characters.count > 0 {
        return false
    }
    return true
}

let num = NSDecimalNumber(string: "0.0000000000000001")
print(num.doubleValue > 0)

let stingT = "123.5%"
print(stingT.characters.count)

class A {
    func M() -> NSObject {
        return NSObject()
    }
}

class B: A {

    override func M() -> NSObject {
        return NSString()
    }
}

struct Container<T> {
    private var list: [T] = [] // I made this private

    subscript(index: Int) -> T {
        get {
            return list[index]
        }
        set(newElm) {
            list.insert(newElm, at: index)
        }
    }
}

var container = Container<[CGFloat]>()
container[0] = [1]
container[1] = [2]
container[2] = [3]
container[3] = [4]
print(container[3])
