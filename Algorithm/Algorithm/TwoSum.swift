//
//  TwoSum.swift
//  Algorithm
//
//  Created by 黄伯驹 on 2018/6/8.
//  Copyright © 2018 伯驹 黄. All rights reserved.
//

func twoSum(_ arr: [Int], target: Int) -> [Int] {
    
    if arr.isEmpty {
        fatalError("数组不能为空")
    }

    var result: [Int] = []
    var dict: [Int: Int] = [arr[0]: 0]

    for (i, n) in arr.enumerated() {
        let m = target - n
        if let idx = dict[m] {
            result.append(idx)
            result.append(i)
        } else {
            dict[n] = i
        }
    }

    return result
}

