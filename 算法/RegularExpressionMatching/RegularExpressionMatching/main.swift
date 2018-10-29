//
//  main.swift
//  RegularExpressionMatching
//
//  Created by 伯驹 黄 on 2017/6/6.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation


private extension String {
    subscript (index: Int) -> Character {
        return self[characters.index(self.startIndex, offsetBy: index)]
    }
    subscript (range: Range<Int>) -> String {
        return self[characters.index(startIndex, offsetBy: range.lowerBound) ..< characters.index(startIndex, offsetBy: range.upperBound)]
    }
    
    var length: Int {
        return characters.count
    }
}


// recursion
func isMatch_recursion(s: String, p: String) -> Bool {
    if p.isEmpty {
        return s.isEmpty
    }
    
    if p.length > 1 && p[1] == "*" {
        return isMatch_recursion(s: s, p: p[2..<p.length]) || s.length != 0 && (s[0] == p[0] || p[0] == ".") && isMatch_recursion(s: s[1..<s.length], p: p)
    } else {
        return s.length != 0 && (s[0] == p[0] || p[0] == ".") && isMatch_recursion(s: s[1..<s.length], p: p[1..<p.length])
    }
}

// dp
func isMatch(s: String, p: String) -> Bool {
    let m = s.length
    let n = p.length

    var f: [[Bool]] = [[Bool]](repeating: [Bool](repeating: false, count: n + 1), count: m + 1)
    f[0][0] = true
    for i in 1 ... n {
        f[0][i] = (i > 1 && "*" == p[i - 1] && f[0][i - 2])
    }
    for i in 1 ... m {
        for j in 1 ... n {
            if p[j - 1] != "*" {
                f[i][j] = f[i - 1][j - 1] && (s[i - 1] == p[j - 1] || "." == p[j - 1])
            } else {
                f[i][j] = f[i][j - 2] || (s[i - 1] == p[j - 2] || "." == p[j - 2]) && f[i - 1][j]
            }
        }
    }
    return f[m][n]
}


print(isMatch(s: "The function prototype should be:", p: "a*"))
