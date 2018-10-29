//
//  main.swift
//  FIFOQueue
//
//  Created by 黄伯驹 on 2017/9/8.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import Foundation

/// 一个能够将元素入队和出队的类型
protocol Queue {
    /// 在 `self` 中所持有的元素的类型
    associatedtype Element
    /// 将 `newElement` 入队到 `self`
    mutating func enqueue(_ newElement: Element) /// 从 `self` 出队一个元素
    mutating func dequeue() -> Element?
}

struct FIFOQueue<Element>: Queue {
    fileprivate var left: [Element] = []
    fileprivate var right: [Element] = []
    /// 将元素添加到队列最后
    /// - 复杂度: O(1)
    mutating func enqueue(_ newElement: Element) {
        right.append(newElement) }
    /// 从队列前端移除一个元素
    /// 当队列为空时，返回 nil
    /// - 复杂度: 平摊 O(1)
    mutating func dequeue() -> Element? {
        if left.isEmpty {
            left = right.reversed()
            right.removeAll()
        }
        return left.popLast()
    }
}

var q = FIFOQueue<String>()

q.enqueue("a")
q.enqueue("b")
q.enqueue("c")
print(q.dequeue())
q.enqueue("e")
q.enqueue("f")
print(q)


Collection


