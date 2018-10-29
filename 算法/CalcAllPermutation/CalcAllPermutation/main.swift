//
//  main.swift
//  CalcAllPermutation
//
//  Created by 伯驹 黄 on 2017/5/31.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

extension String {
    
    var length: Int {
        return characters.count
    }
    
    var arr: [Character] {
        return Array(characters)
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        return substring(to: index(from: to))
    }

    func index(from: Int) -> Index {
        return index(startIndex, offsetBy: from)
    }
}

func isCanSWap(arr: [String], begin: Int, end: Int) -> Bool {

    for i in begin ..< end where arr[i] == arr[end] {
        return false
    }
    return true
}

// 字符串特定区间的字符串排列
func full_permutation(arr: [String], begin: Int, end: Int) {

    var temp = arr
    
    if begin == end - 1 { // 递归之后输出
        print("排列---\(arr)")
    } else {
        for i in begin ..< end {
            let result = isCanSWap(arr: temp, begin: begin, end: i)
            guard result else {
                return
            }

            if i != begin {
                swap(&temp[i], &temp[begin]) // 字符串交换
            }

            full_permutation(arr: temp, begin: begin + 1, end: end)

            if i != begin {
                swap(&temp[i], &temp[begin]) // 字符串恢复
            }
        }
    }
}



full_permutation(arr: ["a", "b", "c", "d", "e"], begin: 0, end: 5)


print("\n===组合===\n")

func stringCombination(str: String) {
    let result: [String] = []
    for i in 1 ... str.length {
        combination(str: str, m: i, result: result)
    }
}

func combination(str: String, m: Int, result: [String]) {
    
    var data = result
    if m == 0 {
        print("FlyElephant--组合---\(result)")
        return
    }

    if !str.isEmpty {
        data.append(str[0]) // 保留第一个字符
        let nextStr = str.substring(from: 1)
        combination(str: nextStr, m: m - 1, result: data) // 第一个字符与m-1个字符之间的组合
        data.removeLast() // 删除最后字符
        combination(str: nextStr, m: m, result: data) // 第一个字符与m个字符之间的组合
    }
}



var str = "abc"
stringCombination(str: str)



