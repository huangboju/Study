//
//  Tries.swift
//  BinaryTree
//
//  Created by 伯驹 黄 on 2017/3/31.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

struct Trie<Element: Hashable> {
    let isElement: Bool
    let children: [Element: Trie<Element>]
}

extension Trie {
    init () {
        isElement = false
        children = [:]
    }
}

extension Trie {
    var elements: [[Element]] {
        var result: [[Element]] = isElement ? [[]] : []
        for (key, value) in children {
            result += value.elements.map { [key] + $0 }
        }
        return result
    }
}

extension Array {
    var slice: ArraySlice<Element> {
        return ArraySlice(self)
    }
}

extension ArraySlice {
    var decomposed: (Element, ArraySlice<Element>)? {
        return isEmpty ? nil : (self[startIndex], self.dropFirst())
    }
}

extension Trie {
    func lookup(key: ArraySlice<Element>) -> Bool {
        guard let (head, tail) = key.decomposed else { return isElement }
        guard let subtrie = children[head] else { return false }
        return subtrie.lookup(key: tail)
    }
}

extension Trie {
    func lookup(key: ArraySlice<Element>) -> Trie<Element>? {
        guard let (head, tail) = key.decomposed else { return self }
        guard let remainder = children[head] else { return nil }
        return remainder.lookup(key: tail)
    }
}


extension Trie {
    func complete(key: ArraySlice<Element>) -> [[Element]] {
        return lookup(key: key)?.elements ?? []
    }
}

extension Trie {
    init (_ key: ArraySlice<Element>) {
        if let (head, tail) = key.decomposed {
            let children = [head: Trie(tail)]
            self = Trie(isElement: false, children: children)
        } else {
            self = Trie ( isElement: true, children: [:])
        }
    }
}


extension Trie {
    func inserting(_ key: ArraySlice<Element>) -> Trie<Element> {
        guard let (head, tail) = key.decomposed else {
            return Trie(isElement: true, children: children)
        }
        var newChildren = children
        if let nextTrie = children[head] {
            newChildren[head] = nextTrie.inserting(tail)
        } else {
            newChildren[head] = Trie(tail)
        }
        return Trie(isElement: isElement, children: newChildren)
    }
}

extension Trie {
    static func build(words: [String]) -> Trie<Character> {
        let emptyTrie = Trie<Character>()
        return words.reduce(emptyTrie) { trie, word in
            trie.inserting(Array(word.characters).slice)
        }
    }
}

extension String {
    func complete(_ knownWords: Trie<Character>) -> [String] {
        let chars = Array(characters).slice
        let completed = knownWords.complete(key: chars)
        return completed.map { chars in
            self + String(chars)
        }
    }
}
//let contents = ["cat", "car", "cart", "dog"]
//let trieOfWords = Trie<Character>.build(words: contents)
//"car".complete(trieOfWords)

