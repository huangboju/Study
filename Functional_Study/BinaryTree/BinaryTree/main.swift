//
//  main.swift
//  BinaryTree
//
//  Created by 伯驹 黄 on 2017/3/10.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

let animals = ["elephant", "zebra", "dog"]
animals.sorted { lhs, rhs in
    let l = lhs.characters.reversed()
    let r = rhs.characters.reversed()
    return l.lexicographicallyPrecedes(r)
}

//struct MySet<Element: Equatable> {
//    var storage: [Element] = []
//    
//    var isEmpty: Bool {
//        return storage.isEmpty
//    }
//
//    func contains(_ element: Element) -> Bool {
//        return storage.contains(element)
//    }
//
//    func inserting(_ x: Element) -> MySet {
//        return contains(x) ? self : MySet(storage: storage + [x])
//    }
//}
//
//
//indirect enum BinarySearchTree<Element: Comparable> {
//    case leaf
//    case node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
//}
//
//let leaf: BinarySearchTree<Int> = .leaf
//let  ve: BinarySearchTree<Int> = .node(leaf, 5, leaf)
//
//
//extension BinarySearchTree {
//    init () {
//        self = .leaf
//    }
//
//    init (_ value: Element) {
//        self = .node(.leaf, value, .leaf)
//    }
//}
//
//
//extension BinarySearchTree {
//    var count: Int {
//        switch self {
//        case .leaf:
//            return 0
//        case let .node(left, _, right ):
//            return 1 + left.count + right.count
//        }
//    }
//
//    var elements: [Element] {
//        switch self {
//        case .leaf:
//            return []
//        case let .node(left, x, right):
//            return left.elements + [x] + right.elements
//        }
//    }
//
//    var countR: Int {
//        return reduce(leaf: 0) { 1 + $0 + $2 }
//    }
//
//    var elementsR: [Element] {
//        return reduce(leaf: []) { $0 + [$1] + $2 }
//    }
//}
//
//extension BinarySearchTree {
//    func reduce<A>(leaf leafF: A, node nodeF: (A, Element, A) -> A) -> A {
//        switch self {
//        case .leaf:
//            return leafF
//        case let .node(left, x, right ):
//            return nodeF(left.reduce(leaf: leafF, node: nodeF), x, right.reduce(leaf: leafF, node: nodeF))
//        }
//    }
//
//    var isEmpty: Bool {
//        if case .leaf = self {
//            return true
//        }
//        return false
//    }
//}
//
//extension Sequence {
//    func all(predicate: (Iterator.Element) -> Bool) -> Bool {
//        for x in self where !predicate(x) {
//            return false
//        }
//        return true
//    }
//}
//
//extension BinarySearchTree where Element: Comparable {
//    var isBST: Bool {
//        switch self {
//        case .leaf:
//            return true
//        case let .node(left, x, right ):
//            return left.elements.all { y in y < x }
//                && right.elements.all { y in y > x }
//                && left.isBST
//                && right.isBST
//        }
//    }
//}
//
//extension BinarySearchTree {
//    func contains(_ x: Element) -> Bool {
//        switch self {
//        case .leaf:
//            return false
//        case let .node(_, y, _) where x == y:
//            return true
//        case let .node(left, y, _) where x < y:
//            return left.contains(x)
//        case let .node(_, y, right) where x > y:
//            return right.contains(x) default:
//                fatalError("The impossible occurred")
//        }
//    }
//}
//
//
//extension BinarySearchTree {
//    mutating func insert(_ x: Element) {
//        switch self {
//        case .leaf:
//            self = BinarySearchTree(x)
//        case .node(var left, let y, var right):
//            if x < y { left.insert(x) }
//            if x > y { right.insert(x) }
//            self = .node(left, y, right)
//        }
//    }
//}

//struct Trie<Element: Hashable> {
//    let isElement: Bool
//    let children: [Element: Trie<Element>]
//}
//
//extension Trie {
//    init () {
//        isElement = false
//        children = [:]
//    }
//}
//
//extension Trie {
//    var elements: [[Element]] {
//        var result: [[ Element]] = isElement ? [[]] : []
//        for (key, value) in children {
//            result += value.elements.map { [key] + $0
//            }
//        }
//        return result
//    }
//}
//
//extension Array {
//    var slice: ArraySlice<Element> {
//        return ArraySlice(self)
//    }
//}
//
//extension ArraySlice {
//    var decomposed: (Element, ArraySlice<Element>)? {
//        return isEmpty ? nil : (self[startIndex], self.dropFirst())
//    }
//}
//
//extension Trie {
//    func lookup(key: ArraySlice<Element>) -> Trie<Element>? {
//        guard let (head, tail) = key.decomposed else { return self }
//        guard let remainder = children[head] else { return nil }
//        return remainder.lookup(key: tail)
//    }
//
//    func complete(key: ArraySlice<Element>) -> [[Element]] {
//        return lookup(key: key)?.elements ?? []
//    }
//
//    init (_ key: ArraySlice<Element>) {
//        if let (head, tail ) = key.decomposed {
//            let children = [head: Trie( tail )]
//            self = Trie(isElement: false, children: children)
//        } else {
//            self = Trie ( isElement: true, children: [:])
//        }
//    }
//
//    func inserting(_ key: ArraySlice<Element>) -> Trie<Element> {
//        guard let (head, tail) = key.decomposed else {
//            return Trie(isElement: true, children: children)
//        }
//        var newChildren = children
//        if let nextTrie = children[head] {
//            newChildren[head] = nextTrie.inserting(tail)
//        } else {
//            newChildren[head] = Trie(tail)
//        }
//        return Trie(isElement: isElement, children: newChildren)
//    }
//
//    static func build(words: [String]) -> Trie<Character> {
//        let emptyTrie = Trie<Character>()
//        return words.reduce(emptyTrie) { trie, word in
//            trie.inserting(Array(word.characters).slice)
//        }
//    }
//}
//
//extension String {
//    
//    func complete(_ knownWords: Trie<Character>) -> [String] {
//        let chars = Array(characters).slice
//        let completed = knownWords.complete(key: chars)
//        return completed.map { chars in
//            self + String(chars)
//        }
//    }
//}
//
//let contents = ["cat", "car", "cart", "dog"]
//let trieOfWords = Trie<Character>.build(words: contents)
//print(trieOfWords)
//print("car".complete(trieOfWords))


//struct Trie<Element: Hashable> {
//    var isElement: Bool
//    var children: [Element: Trie<Element>]
//}
//
//extension Trie {
//    init () {
//        isElement = false
//        children = [:]
//    }
//}
//
//extension Trie {
//    var elements: [[Element]] {
//        var result: [[ Element]] = isElement ? [[]] : []
//        for (key, value) in children {
//            result += value.elements.map { [key] + $0 }
//        }
//        return result
//    }
//}
//
//extension Array {
//    var slice: ArraySlice<Element> {
//        return ArraySlice(self)
//    }
//}
//
//extension ArraySlice {
//    var decomposed: (Element, ArraySlice<Element>)? {
//        return isEmpty ? nil : (self[startIndex], self.dropFirst())
//    }
//}
//
//extension Trie {
//
//    func lookup(key: ArraySlice<Element>) -> Bool {
//        guard let (head, tail) = key.decomposed else { return isElement }
//        guard let subtrie = children[head] else { return false }
//        return subtrie.lookup(key: tail)
//    }
//
//    init (_ key: ArraySlice<Element>) {
//        if let (head, tail) = key.decomposed {
//            let children = [head: Trie(tail)]
//            self = Trie(isElement: false, children: children)
//        } else {
//            self = Trie(isElement: true, children: [:])
//        }
//    }
//
//    func inserting(_ key: ArraySlice<Element>) -> Trie<Element> {
//        guard let (head, tail) = key.decomposed else {
//            return Trie(isElement: true, children: children)
//        }
//        var newChildren = children
//        if let nextTrie = children[head] {
//            newChildren[head] = nextTrie.inserting(tail)
//        } else {
//            newChildren[head] = Trie(tail)
//        }
//        return Trie(isElement: isElement, children: newChildren)
//    }
//
//    func remove(_ key: ArraySlice<Element>) -> Trie<Element> {
//        guard let (head, tail) = key.decomposed else {
//            return Trie(isElement: true, children: children)
//        }
//        var newChildren = children
//        if let nextTrie = children[head] {
//            newChildren[head] = Trie(isElement: true, children: [:])
//            nextTrie.remove(tail)
//        }
//        
//        return Trie(isElement: isElement, children: newChildren)
//    }
//
//    static func build(urlStr: String, emptyTrie: Trie<String>? = nil) -> Trie<String> {
//        let emptyTrie = emptyTrie ?? Trie<String>()
//        let components = urlStr.decomposed
//        return emptyTrie.inserting(components.slice)
//    }
//}
//
//extension String {
//
//    var decomposed: [String] {
//        var components: [String] = []
//        guard let url = URL(string: self) else { return components }
//        guard let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: false) else { return components }
//
//        guard let sheme = urlComponents.scheme else {
//            return components
//        }
//        components.append(sheme + "://")
//
//        guard let host = urlComponents.host else {
//            return components
//        }
//        components.append(host + "/")
//        
//        guard let query = urlComponents.query else {
//            return components
//        }
//        components.append("?" + query)
//        return components
//    }
//
//    func complete(knownWords: Trie<String>) -> Bool {
//        let chars = decomposed.slice
//        return knownWords.lookup(key: chars)
//    }
//    
//    func remove(knownWords: Trie<String>) {
//        let chars = decomposed.slice
//        guard knownWords.lookup(key: chars) else {
//            return
//        }
//    }
//}
//
//let trieOfUrl = Trie<String>.build(urlStr: "http://page/detail?title=hah")
//print(trieOfUrl, "\n\n")
//
//print(Trie<String>.build(urlStr: "http://page/detail?title=aaa", emptyTrie: trieOfUrl))
//print("http://page/detail?title=hah".complete(knownWords: trieOfUrl))



func mergeSort<T: Comparable>(_ array: [T]) -> [T] {
    guard array.count > 1 else { return array }
    let middleIndex = array.count / 2
    let leftArray = mergeSort(Array(array[0..<middleIndex]))
    let rightArray = mergeSort(Array(array[middleIndex..<array.count]))
    return merge(leftPile: leftArray, rightPile: rightArray)
}

func merge<T: Comparable>(leftPile: [T], rightPile: [T]) -> [T] {
    var leftIndex = 0
    var rightIndex = 0
    var orderedPile = [T]()
    if orderedPile.capacity < leftPile.count + rightPile.count {
        orderedPile.reserveCapacity(leftPile.count + rightPile.count)
    }
    
    while leftIndex < leftPile.count && rightIndex < rightPile.count {
        if leftPile[leftIndex] < rightPile[rightIndex] {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
        } else if leftPile[leftIndex] > rightPile[rightIndex] {
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        } else {
            orderedPile.append(leftPile[leftIndex])
            leftIndex += 1
            orderedPile.append(rightPile[rightIndex])
            rightIndex += 1
        }
    }
    
    while leftIndex < leftPile.count {
        orderedPile.append(leftPile[leftIndex])
        leftIndex += 1
    }
    
    while rightIndex < rightPile.count {
        orderedPile.append(rightPile[rightIndex])
        rightIndex += 1
    }
    
    return orderedPile
}

let array = [2, 1, 5, 4, 9]
let sortedArray = mergeSort(array)
let array2 = ["Tom", "Harry", "Ron", "Chandler", "Monica"]
let sortedArray2 = mergeSort(array2)
print(sortedArray2)


func bubbleSort(_ arr: [Int]) -> [Int] {
    var a = arr

    while true {
        var swaped = false
        
        for i in 1 ..< a.count where a[i] > a[i - 1] {
            swap(&a[i], &a[i-1])
            swaped = true
        }
        if !swaped {
            break
        }
    }
    return a
}

func insertionSort(_ arr: [Int]) -> [Int] {
    var a = arr
    
    for i in 1 ..< arr.count {
        var j = i
        while j > 0 && a[j] > a[j - 1] {
            swap(&a[j], &a[j-1])
            j -= 1
        }
    }
    
    return a
}

print(insertionSort(array))

var arr = [64, 20, 50, 33, 72, 10, 23, -1, 4, 5]


func shellSor(_ arr: [Int]) -> [Int] {
    var sortedArr = arr
    var step = arr.count / 2
    
    while step > 0 {

        for i in stride(from: 0, to: sortedArr.count, by: step) {
            var j = i
            while j >= step && j < sortedArr.count && sortedArr[j] > sortedArr[j - step] {
                swap(&sortedArr[j], &sortedArr[j - step])
                j -= step
            }
        }
        
        step /= 2
    }
    
    return sortedArr
}


func shellSort(_ arr: [Int]) -> [Int] {
    
    var list = arr

    var sublistCount = list.count / 2

    while sublistCount > 0 {
        
        for index in 0..<list.count {

            guard index + sublistCount < list.count else { break }

            if list[index] > list[index + sublistCount] {
                swap(&list[index], &list[index + sublistCount])
            }

            guard sublistCount == 1 && index > 0 else { continue }

            if list[index - 1] > list[index] {
                swap(&list[index - 1], &list[index])
            }
        }
        sublistCount = sublistCount / 2
    }
    return list
}

print(shellSor(arr))

func selectionSort(_ array: [Int]) -> [Int] {
    guard array.count > 1 else { return array }  // 1
    
    var a = array                    // 2
    
    for x in 0 ..< a.count - 1 {     // 3
        
        var lowest = x
        for y in x + 1 ..< a.count {   // 4
            if a[y] < a[lowest] {
                lowest = y
            }
        }

        if x != lowest {               // 5
            swap(&a[x], &a[lowest])
        }
    }
    return a
}

print(selectionSort(arr))
