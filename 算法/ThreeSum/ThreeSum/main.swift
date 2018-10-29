//
//  main.swift
//  ThreeSum
//
//  Created by 伯驹 黄 on 2017/6/7.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation


class Medium_015_3Sum {
    // O (N^2)
    class func threeSum(_ num: [Int]) -> [[Int]] {
        var res: [[Int]] = []
        if num.count < 3 {
            return res
        } else {
            var sorted: [Int] = num.sorted {$0 < $1}
            var twoSum: Int
            let size = sorted.count
            var i = 0
            while i < size - 2 {
                var l = i + 1
                var r = size - 1
                twoSum = 0 - sorted[i]
                while l < r {
                    if sorted[l] + sorted[r] < twoSum {
                        l += 1
                    } else if sorted[l] + sorted[r] == twoSum {

                        var three: [Int] = []
                        three.append(sorted[i])
                        three.append(sorted[l])
                        three.append(sorted[r])
                        res.append(three)

                        repeat {
                            l += 1
                        } while l < r && sorted[l - 1] == sorted[l]

                        repeat {
                            r -= 1
                        } while l < r && sorted[r + 1] == sorted[r]
                    } else {
                        r -= 1
                    }
                }

                repeat {
                    i += 1
                } while i < size - 1 && sorted[i-1] == sorted[i]
            }
            return res
        }
    }
}
