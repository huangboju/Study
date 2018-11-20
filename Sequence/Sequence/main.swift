//
//  main.swift
//  Sequence
//
//  Created by 伯驹 黄 on 2017/2/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

// http://www.hangge.com/blog/cache/detail_1377.html

// 命名一个坐标点类型
typealias PointType = (x: Int, y: Int)

// 返回所有符合条件的坐标点序列
func cartesianSequence(xCount: Int, yCount: Int) -> UnfoldSequence<PointType, Int> {
    assert(xCount > 0 && yCount > 0,
           "必须使用正整数创建序列。")
    return sequence(state: 0, next: {
        (index: inout Int) -> PointType? in
        guard index < xCount * yCount else { return nil }
        defer { index += 1 }
        return (x: index % xCount, y: index / xCount)
    })
}

// 遍历序列并打印出所有坐标
for point in cartesianSequence(xCount: 5, yCount: 3) {
    print("(x: \(point.x), y: \(point.y))")
}

// 图书
struct Book {
    var name: String
}

// 书架
class BookShelf {
    // 图书集合
    private var books: [Book] = []

    // 添加新书
    func append(book: Book) {
        books.append(book)
    }

    // 创建Iterator
    func makeIterator() -> AnyIterator<Book> {
        var index: Int = 0
        return AnyIterator<Book> {
            defer {
                index = index + 1
            }
            return index < self.books.count ? self.books[index] : nil
        }
    }
}

// 中文书架
let bookShelf1 = BookShelf()
bookShelf1.append(book: Book(name: "平凡的世界"))
bookShelf1.append(book: Book(name: "活着"))
bookShelf1.append(book: Book(name: "围城"))
bookShelf1.append(book: Book(name: "三国演义"))

// 外文书架
let bookShelf2 = BookShelf()
bookShelf2.append(book: Book(name: "The Kite Runner"))
bookShelf2.append(book: Book(name: "Cien anos de soledad"))
bookShelf2.append(book: Book(name: "Harry Potter"))

// 创建两个书架图书的交替序列
for book in sequence(state: (false, bookShelf1.makeIterator(), bookShelf2.makeIterator()),
                     next: { (state: inout (Bool, AnyIterator<Book>, AnyIterator<Book>)) -> Book? in
                         state.0 = !state.0
                         return state.0 ? state.1.next() : state.2.next()
}) {
    print(book.name)
}

let lazyResult = Array((1 ... 10).lazy.filter { $0 % 3 == 0 }.map { $0 * $0 })
print(lazyResult)
