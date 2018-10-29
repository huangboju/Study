//
//  main.swift
//  LongestPalindromicSubstring
//
//  Created by 伯驹 黄 on 2017/5/30.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation


extension String {

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    subscript (r: Range<Int>) -> String {
        let lower = max(0, min(count, r.lowerBound))
        let upper = min(count, max(0, r.upperBound))
        let range = Range(uncheckedBounds: (lower: lower, upper: upper))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }

    func substr(with range: NSRange) -> String {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(endIndex, offsetBy: range.location + range.length - count)
        return String(self[start ..< end])
    }
    
    var toArr: [Character] {
        return Array(self)
    }
}


func preProcess(_ s: String) -> String {
    let n = s.count
    if n == 0 {
        return "$"
    }
    var ret = "$"
    for c in s {
        ret += ("#" + "\(c)")
    }
    ret += "#"
    return ret
}

// https://github.com/julycoding/The-Art-Of-Programming-By-July/blob/master/ebook/zh/01.05.md
// https://segmentfault.com/a/1190000002991199
func longestPalindrome(_ s: String) -> String {
    let T = preProcess(s)

    let n = T.count
    var P = Array(repeating: 0, count: n)
    // id表示最大回文子串中心的位置
    var id = 0
    // mx则为id+P[id],也就是最大回文子串的边界
    var mx = 0
    //    i: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17
    //    S: $ # 1 # 2 # 2 # 1 #  2  #  3  #  2  #  1  #
    //    P:   1 2 1 2 5 2 1 4 1  2  1  6  1  2  1  2  1
    var maxLen = 0
    var centerIndex = 0
    for  i in 1 ..< n - 1 {
        // i_mirror是i关于id的对称点
        let i_mirror = 2 * id - i // equals to i' = id - (i - id)

        P[i] = (mx > i) ? min(mx - i, P[i_mirror]) : 1

        // 试图扩大以i为中心的回文
        while T[i + P[i]] == T[i - P[i]] {
            P[i] += 1
        }

        // 如果回文以mx为中心扩展，则根据扩展的回文调整中心。
        if i + P[i] > mx {
            id = i
            mx = i + P[i]
        }
        if P[i] - 1 > maxLen {
            maxLen = P[i] - 1
            centerIndex = i
        }
    }

    // Find the maximum element in P.
    let range = NSRange(location: (centerIndex - 1 - maxLen)/2, length: maxLen)
    let substr = s.substr(with: range)

    return substr
}


print(longestPalindrome("12212321"))















private extension String {
    /*
     Ref: http://oleb.net/blog/2014/07/swift-strings/
     "Because of the way Swift strings are stored, the String type does not support random access to its Characters via an integer index — there is no direct equivalent to NSStringʼs characterAtIndex: method. Conceptually, a String can be seen as a doubly linked list of characters rather than an array."
     
     By creating and storing a seperate array of the same sequence of characters,
     we could hopefully achieve amortized O(1) time for random access.
     */
    func randomAccessCharactersArray() -> [Character] {
        return Array(self)
    }
}

func longestPalindrome1(_ s: String) -> String {
    guard s.count > 1 else {
        return s
    }
    var startIndex: Int = 0
    var maxLen: Int = 1
    var i = 0
    let charArr = s.randomAccessCharactersArray()
    
    while i < s.count {
        guard s.count - i > maxLen / 2 else {
            break
        }
        
        var j = i
        var k = i

        while k < s.count - 1 && charArr[k+1] == charArr[k] {
            k += 1
        }
        i = k + 1
        
        
        while k < s.count - 1 && j > 0 && charArr[k+1] == charArr[j-1] {
            k += 1
            j -= 1
        }

        let newLen = k - j + 1
        if newLen > maxLen {
            startIndex = j
            maxLen = newLen
        }
    }
    return String(charArr[startIndex ..< (startIndex + maxLen)])
}

print(longestPalindrome1("12212321"))


