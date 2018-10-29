//
//  main.swift
//  IsPalindrome
//
//  Created by 伯驹 黄 on 2017/5/26.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation


extension String {
    var toArray: [Character] {
        return Array(characters)
    }
}

func IsPalindrome(_ str: String) -> Bool {
    
    let strs = str.toArray
    
    for i in 0 ..< strs.count {
        let fornt = strs[i]
        let back = strs[strs.count - i - 1]
        if fornt != back {
            return false
        }
    }

    return true
}




//func IsPalindrome2(_ str: String) -> Bool {
//    
//    let strs = str.toArray
//    
//    let n = strs.count
//    
//    let m = max((n >> 1) - 1, 0)
//
//    let s = (m + n) % n
//    let front = strs[s ..< n]
//
//    let back = strs[n - 1 - m ..< n]
//
//    var first = s
//    var second = n - 1 - m
//
//    while first >= n {
//        if front[first] != back[second] {
//            return false
//        }
//        first -= 1
//        second += 1
//    }
//
//    return true
//}


let str = "1211"

print(IsPalindrome(str))
//print(IsPalindrome2(str))





