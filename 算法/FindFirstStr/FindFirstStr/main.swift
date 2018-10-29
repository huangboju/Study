//
//  main.swift
//  FindFirstStr
//
//  Created by 伯驹 黄 on 2017/6/1.
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

func findFirstStr(string: String) -> String {
    let str = string
    var dict: [String: Int] = [:]
    for i in 0 ..< str.length {
        let char = str[i]
        if let count = dict[char] {
            dict[char] = count + 1
        } else {
            dict[char] = 1
        }
    }
    var result = ""
    for c in str.characters {
        if dict["\(c)"]! == 1 {
            result = "\(c)"
            break
        }
    }
    return result
}

var firstChar = findFirstStr(string: "1341345526")
print("第一次只出现一次的字符=\(firstChar)")




