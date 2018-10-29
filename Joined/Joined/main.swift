//
//  main.swift
//  Joined
//
//  Created by 伯驹 黄 on 2017/3/2.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

let array2D = [[2, 3], [8, 10], [9, 5], [4, 8]]

if array2D.joined().contains(8) {
    print("contains 8")
} else {
    print("doesn't contain 8")
}

let array = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
let j = Array(array.joined(separator: [42]))

print(j)

let strs = ["1", "2", "4"]
let str = strs.joined(separator: ",")
print(str)

let ranges = [0 ..< 3, 8 ..< 10, 15 ..< 17]

for index in ranges.joined() {
    print(index, terminator: " ")
}
