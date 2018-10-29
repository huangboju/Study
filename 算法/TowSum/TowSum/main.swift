//
//  main.swift
//  TowSum
//
//  Created by 伯驹 黄 on 2017/6/2.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

func twoSum(_ arr: [Int], target: Int) -> [(Int, Int)] {
    var result: [(Int, Int)] = []
    
    var dict: [Int: Int] = [:]
    
    for (i, n) in arr.enumerated() {
        let m = target - n
        if let idx = dict[m] {
            result.append((idx, i))
        } else {
            dict[n] = i
        }
    }
    
    return result
}


print(twoSum([2, 7, 11, 15, 1, 8], target: 9))
