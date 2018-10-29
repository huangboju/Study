//
//  main.swift
//  LinkedList
//
//  Created by 黄伯驹 on 2018/4/23.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

import Foundation

class LinkedList<T> {
    
    class LinkedListNode<T> {
        var value: T
        var next: LinkedListNode?
        weak var previous: LinkedListNode?
        
        public init(value: T) {
            self.value = value
        }
    }
    
    public typealias Node = LinkedListNode<T>
    
    fileprivate var head: Node?
    
    public init() {}
    
    public var isEmpty: Bool {
        return head == nil
    }
    
    public var first: Node? {
        return head
    }
    
    public var last: Node? {
        guard var node = head else {
            return nil
        }
        
        while let next = node.next {
            node = next
        }
        return node
    }
    
    public var count: Int {
        guard var node = head else {
            return 0
        }
        
        var count = 1
        while let next = node.next {
            node = next
            count += 1
        }
        return count
    }
    
    
    public func node(at index: Int) -> Node {
        assert(head != nil, "List is empty")
        assert(index >= 0, "index must be greater than 0")
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            
            assert(node != nil, "index is out of bounds.")
            return node!
        }
    }
    
    public subscript(index: Int) -> T {
        let node = self.node(at: index)
        return node.value
    }
    
    public func append(_ value: T) {
        let newNode = Node(value: value)
        self.append(newNode)
    }
    
    public func append(_ node: Node) {
        let newNode = node
        if let lastNode = last {
            newNode.previous = lastNode
            lastNode.next = newNode
        } else {
            head = newNode
        }
    }
    
    public func append(_ list: LinkedList) {
        var nodeToCopy = list.head
        while let node = nodeToCopy {
            self.append(node.value)
            nodeToCopy = node.next
        }
    }
    
    public func insert(_ value: T, at index: Int) {
        let newNode = Node(value: value)
        self.insert(newNode, at: index)
    }
    
    public func insert(_ newNode: Node, at index: Int) {
        if index == 0 {
            newNode.next = head
            head?.previous = newNode
            head = newNode
        } else {
            let prev = node(at: index-1)
            let next = prev.next
            newNode.previous = prev
            newNode.next = next
            next?.previous = newNode
            prev.next = newNode
        }
    }
    
    public func insert(_ list: LinkedList, at index: Int) {
        if list.isEmpty { return }
        
        if index == 0 {
            list.last?.next = head
            head = list.head
        } else {
            let prev = self.node(at: index-1)
            let next = prev.next
            
            prev.next = list.head
            list.head?.previous = prev
            
            list.last?.next = next
            next?.previous = list.last?.next
        }
    }
    
    public func removeAll() {
        head = nil
    }
    
    @discardableResult public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        next?.previous = prev
        
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    @discardableResult public func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    @discardableResult public func remove(at index: Int) -> T {
        let node = self.node(at: index)
        return remove(node: node)
    }
}

