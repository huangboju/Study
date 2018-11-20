//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

struct Stack<T> {
    fileprivate var array = [T]()

    var count: Int {
        return array.count
    }

    var isEmpty: Bool {
        return array.isEmpty
    }

    mutating func push(_ element: T) {
        array.append(element)
    }

    mutating func pop() -> T? {
        return array.popLast()
    }

    func peek() -> T? {
        return array.last
    }
}

var stack = Stack(array: [1, 2, 3, 4, 6])

stack.array
stack.push(5)
stack.array
stack.pop()
stack.peek()
stack.array
