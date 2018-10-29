//
//  main.swift
//  ReverseInteger
//
//  Created by 伯驹 黄 on 2017/6/6.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

// t = O(N), s = O(1)
func reverse(_ x: Int) -> Int {
    var negtive = false
    var i: UInt
    if x < 0 {
        negtive = true
        if x == Int.min {
            // The "minus 1 then add 1" trick is used to negate Int.min without overflow
            i = UInt(-(x+1))
            i += 1
        } else {
            i = UInt(-x)
        }
    } else {
        i = UInt(x)
    }

    var res: UInt = 0
    while i > 0 {
        res = res * 10 + UInt(i % 10)
        i = i / 10
    }

    if !negtive && res > UInt(Int.max) {
        return 0
    } else if negtive && res > UInt(Int.max) + 1 {
        return 0
    }

    if negtive {
        return (-1) * Int(res)
    } else {
        return Int(res)
    }
}


print(reverse(102))
