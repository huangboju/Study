//
//  LongestSubstrWithoutRepeatingChar.swift
//  Algorithm
//
//  Created by 黄伯驹 on 2018/6/8.
//  Copyright © 2018 伯驹 黄. All rights reserved.
//

// 最长不重复子串
extension String {
    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return self[Range(start ..< end)]
    }
}

func longestSubStr(_ str: String) -> String {
    var result = ""
    var longestStr = ""
    var dict: [Character: Int] = [:]
    
    for (i, char) in str.enumerated() {
        if let lastIndex = dict[char] {
            if lastIndex < i - longestStr.count {
                longestStr.append(char)
            } else {
                longestStr = str[lastIndex ..< i]
            }
        } else {
            longestStr.append(char)
        }
        dict[char] = i
        if longestStr.count > result.count {
            result = longestStr
        }
    }
    return result
}

