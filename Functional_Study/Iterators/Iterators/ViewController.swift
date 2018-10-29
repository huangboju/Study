//
//  ViewController.swift
//  Iterators
//
//  Created by 伯驹 黄 on 2017/4/12.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let letters = ["A", "B", "C"]
        var iterator = ReverseIndexIterator(array: letters)
        while let i = iterator.next() {
            print ( "Element \(i) of the array is \( letters[ i ]) " )
        }

        var powerIterator = PowerIterator()
        print(powerIterator.find { $0.intValue > 1000 })

        var array = ["one", "two", "three"]
        let reverseSequence = ReverseArrayIndices(array: array)
        var reverseIterator = reverseSequence.makeIterator()
        while let i = reverseIterator.next() {
            print("Index \(i) is \(array[i])")
        }

        
        let reverseElements = ReverseArrayIndices(array: array).map { array[$0] }
        for x in reverseElements {
            print("Element is \(x)")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

struct ReverseIndexIterator: IteratorProtocol {
    var index: Int

    init<T>(array: [T]) {
        index = array.endIndex - 1
    }

    mutating func next() -> Int? {
        guard index >= 0 else { return nil }
        defer { index -= 1 }
        return index
    }
}

struct PowerIterator: IteratorProtocol {
    var power: NSDecimalNumber = 1

    mutating func next() -> NSDecimalNumber? {
        power = power.multiplying(by: 2)
        return power
    }
}


extension PowerIterator {
    mutating func find(where predicate: (NSDecimalNumber) -> Bool) -> NSDecimalNumber? {
            while let x = next() {
            if predicate(x) {
                return x
            }
        }
        return nil
    }
}


struct FileLinesIterator: IteratorProtocol {
    let lines: [String]

    var currentLine: Int = 0

    init (filename: String) throws {
        let contents: String = try String(contentsOfFile: filename)
        lines = contents.components(separatedBy: .newlines)
    }

    mutating func next() -> String? {
        guard currentLine < lines.endIndex else { return nil }
        defer { currentLine += 1 }
        return lines[currentLine]
    }
}



struct LimitIterator<I: IteratorProtocol>: IteratorProtocol {
    var limit = 0
    var iterator: I
    init(limit: Int, iterator: I) {
        self.limit = limit
        self.iterator = iterator
    }

    mutating func next() -> I.Element? {
        guard limit > 0 else { return nil }
        limit -= 1
        return iterator.next()
    }
}

extension Int {
    func countDown() -> AnyIterator<Int> {
        var i = self - 1
        return AnyIterator {
            guard i >= 0 else { return nil }
            defer { i -= 1 }
            return i
        }
    }
}

func + <I: IteratorProtocol, J: IteratorProtocol>(first : I , second: J) -> AnyIterator<I.Element> where I.Element == J.Element {
    var i = first
    var j = second
    return AnyIterator { i.next() ?? j .next() }
}

func + <I: IteratorProtocol, J: IteratorProtocol>(first: I, second: @escaping@autoclosure()->J ) -> AnyIterator<I.Element> where I.Element == J.Element {
    var one = first
    var other: J?
    return AnyIterator {
        if other != nil {
            return other!.next()
        } else if let result = one.next() {
            return result
        } else {
            other = second()
            return other!.next()
        }
    }
}



struct ReverseArrayIndices<T>: Sequence {
    let array: [T]
    init(array: [T]) {
        self.array = array
    }

    func makeIterator() -> ReverseIndexIterator {
        return ReverseIndexIterator(array: array)
    }
}


indirect enum BinarySearchTree<Element: Comparable> {
    case leaf
    case node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

extension BinarySearchTree: Sequence {
    func makeIterator() -> AnyIterator<Element> {
        switch self {
        case .leaf:
            return AnyIterator { return nil }
        case let .node(l, element, r):
            return l.makeIterator() + CollectionOfOne(element).makeIterator() + r.makeIterator()
        }
    }
}
