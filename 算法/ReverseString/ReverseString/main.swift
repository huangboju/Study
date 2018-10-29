//
//  main.swift
//  ReverseString
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


func ReverseString(_ arr: inout [Character], _ from: Int, _ to: Int) {
    // arr[from..<to].reverse()
    
    var from = from
    var to = to
    
    while from < to {
        swap(&arr[from], &arr[to])
        from += 1
        to -= 1
    }
}

func LeftRotateString(_ s: String, m: Int) -> String {
    var arr = s.toArray
    let m = m % arr.count
    ReverseString(&arr, 0, m - 1)
    ReverseString(&arr, m, arr.count - 1)
    ReverseString(&arr, 0, arr.count - 1)
    return arr.reduce("") {
        return $0.0 + "\($0.1)"
    }
}



print(LeftRotateString("abcdef", m: 8))


func ReverseStr(_ arr: inout [String], _ from: Int, _ to: Int) {
    // words.reverse()

    var from = from
    var to = to
    
    while from < to {
        swap(&arr[from], &arr[to])
        from += 1
        to -= 1
    }
}

func reverseWord(_ str: String) -> String {
    var words = str.components(separatedBy: " ")
    ReverseStr(&words, 0, words.count - 1)
    return words.reduce("") {
        $0.0 + (($0.0 == "") ? "" : " ") + $0.1
    }
}

print(reverseWord("I am a student."))



