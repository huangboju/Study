//
//  main.swift
//  MergeSortedArray
//
//  Created by 伯驹 黄 on 2017/6/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

let arr1 = [1, 2, 5, 6, 7]
let arr2 = [2, 3, 4, 6]

// let result = [1, 2, 2, 3, 4, 5, 6, 6, 7]


func merge(_ arr1: [Int], _ arr2: [Int]) -> [Int] {
    var result: [Int] = []
    
    let longArr = arr1.count > arr2.count ? arr1 : arr2
    let shortArr = arr1.count < arr2.count ? arr1 : arr2

    var i = 0

    for n in longArr {
        if n > shortArr[i] {
            result.append(shortArr[i])
            i += 1
            while i < shortArr.count && shortArr[i] < n {
               result.append(shortArr[i])
                i += 1
            }
        }
        result.append(n)
    }

    return result
}


print(merge(arr1, arr2))



