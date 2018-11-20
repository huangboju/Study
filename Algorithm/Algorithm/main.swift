//
//  main.swift
//  Algorithm
//
//  Created by 伯驹 黄 on 2016/12/14.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

public func random(min: Int, max: Int) -> Int {
    assert(min < max)
    return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

func select<T>(from a: [T], count k: Int) -> [T] {
    var a = a
    for i in 0..<k {
        let r = random(min: i, max: a.count - 1)
        if i != r {
            a.swapAt(i, r)
        }
    }
    return Array(a[0..<k])
}


func binarySearch<T: Comparable>(_ n: [T], key: T) -> Int? {
    var start = 0, end = n.count - 1
    while start + 1 < end {
        let mid = start + (end - start) / 2
        if n[mid] <= key {
            start = mid
        } else {
            end = mid
        }
    }
    return nil
}

print(binarySearch([1, 2, 5, 7, 9, 10], key: 5))

let arr = [ "a", "b", "c", "d", "e", "f", "g" ]
print(select(from: arr, count: 3))

print(twoSum([2, 7, 11, 15, 1, 8], target: 9))

print(longestSubStr("abczzacbca"))

let arr1 = [1, 2, 5, 7, 9, 10]
let arr2 = [3, 4, 6, 8]

print(findMedianSorted(arr1, arr2))

print(findMedianSortedArrays(arr2, arr1))
