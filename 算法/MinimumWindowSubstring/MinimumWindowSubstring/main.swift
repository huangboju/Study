//
//  main.swift
//  MinimumWindowSubstring
//
//  Created by 伯驹 黄 on 2017/6/3.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

private extension String {
    subscript (index: Int) -> Character {
        return self[characters.index(startIndex, offsetBy: index)]
    }
    
    var length: Int {
        return characters.count
    }

    func substring(with range: NSRange) -> String {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(endIndex, offsetBy: range.location + range.length - characters.count)
        return substring(with: start ..< end)
    }

    func substring(fromIndex: Int, toIndex: Int) -> String {
        let range = NSRange(location: fromIndex, length: toIndex - fromIndex)
        return substring(with: range)
    }
}

func minWindow(s: String, t: String) -> String {
    if s.isEmpty || t.isEmpty {
        return ""
    }
    var count = t.length
    var charCountDict: [Character: Int] = [:]
    for c in t.characters {
        if let charCount = charCountDict[c] {
            charCountDict[c] = charCount + 1
        } else {
            charCountDict[c] = 1
        }
    }
    var right = -1
    var left = 0
    var minLen = Int.max
    var minIdx = 0
    while right < s.length && left < s.length {
        if count > 0 {
            right += 1 // 这里为了能进入下面分支，一定要先+1。
            if right == s.length {
                // 最后一次走这里
                continue
            }
            let c = s[right]
            if let charCount = charCountDict[c] {
                // 防止连续出现 s: "AAABBBCCC", t: "ABC"
                charCountDict[c] = charCount - 1
            } else {
                // 目标字符串不存在的字符，随便给一个负数即可
                charCountDict[c] = -1
            }
            if charCountDict[c]! >= 0 {
                count -= 1
            }
        } else {
            // 目标字符串全部索引完后进入这支
            if minLen > right - left + 1 {
                minLen = right - left + 1
                minIdx = left
            }
            let c = s[left]
            if let charCount = charCountDict[c] {
                charCountDict[c] = charCount + 1
            } else {
                // 目标字符串不存在的字符，随便给一个负数即可
                charCountDict[c] = -1
            }
            if charCountDict[c]! > 0 {
                count += 1
            }
            left += 1
        }
    }
    if minLen == Int.max {
        return ""
    }

    return s.substring(fromIndex: minIdx, toIndex: minIdx + minLen)
}


print(minWindow(s: "ADOBECODEBANC", t: "ABC"))

