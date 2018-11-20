//
//  MaxConsecutiveOnes.swift
//  Algorithm
//
//  Created by 黄伯驹 on 2018/6/8.
//  Copyright © 2018 伯驹 黄. All rights reserved.
//

func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
    var globalMax = 0, localMax = 0
    
    for num in nums {
        if num == 1 {
            localMax += 1
            globalMax = max(globalMax, localMax)
        } else {
            localMax = 0
        }
    }
    
    return globalMax
}
