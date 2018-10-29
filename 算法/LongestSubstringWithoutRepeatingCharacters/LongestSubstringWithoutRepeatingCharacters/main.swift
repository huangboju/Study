//
//  main.swift
//  LongestSubstringWithoutRepeatingCharacters
//
//  Created by 伯驹 黄 on 2017/6/2.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

private extension String {
    /*
     Ref: http://oleb.net/blog/2014/07/swift-strings/
     "Because of the way Swift strings are stored, the String type does not support random access to its Characters via an integer index — there is no direct equivalent to NSStringʼs characterAtIndex: method. Conceptually, a String can be seen as a doubly linked list of characters rather than an array."
     
     By creating and storing a seperate array of the same sequence of characters,
     we could hopefully achieve amortized O(1) time for random access.
     */
    var array: [Character] {
        return Array(self)
    }
    
    var length: Int {
        return count
    }
    
    var arr: [Character] {
        return Array(self)
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }

    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }

    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }

    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }

    subscript (r: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: r.lowerBound)
        let end = index(startIndex, offsetBy: r.upperBound)
        return self[Range(start ..< end)]
    }
    
    func substring(to: Int) -> String {
        return substring(to: index(from: to))
    }
    
    func index(from: Int) -> Index {
        return index(startIndex, offsetBy: from)
    }
}

func longest(_ s: String) -> Int {
    
    let chars = s.array

    var dict: [Character: Int] = [:]
    var maxLen = 0
    var tempLen = 0

    for (i, c) in chars.enumerated() {
        if let lastPosition = dict[c] {
            if lastPosition < i - tempLen {
                // "ppwwpwkew"
                tempLen += 1
            } else {
                tempLen = i - lastPosition
            }
        } else {
            tempLen += 1
        }
        dict[c] = i
        maxLen = max(maxLen, tempLen)
    }
    return maxLen
}


func longest1(_ s: String) -> String {
    
    let chars = s.array
    
    var dict: [Character: Int] = [:]
    var maxLen = ""
    var tempLen = ""

    for (i, c) in chars.enumerated() {
        if let lastPosition = dict[c] {
            if lastPosition < i - tempLen.length {
                // "ppwwpwkew"
                tempLen.append(c)
            } else {
                tempLen = s[lastPosition ..< i]
            }
        } else {
            tempLen.append(c)
        }
        dict[c] = i
        if tempLen.length > maxLen.length {
            maxLen = tempLen
        }
    }
    return maxLen
}


print(longest1("abczzacca"))

