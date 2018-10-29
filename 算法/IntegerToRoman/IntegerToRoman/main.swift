//
//  main.swift
//  IntegerToRoman
//
//  Created by 伯驹 黄 on 2017/6/7.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class Medium_012_Integer_To_Roman {
    
    // 0, 1000, 2000, 3000
    private static var M: [String] = ["", "M", "MM", "MMM"]

    // 0, 100, 200, 300, 400, 500, 600, 700, 800, 900
    private static var C: [String] = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]

    // 0, 10, 20, 30, 40, 50, 60, 70, 80, 90,
    private static var X: [String] = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
    
    // 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
    private static var I: [String] = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
    
    // O (1)
    class func integerToRoman(num: Int) -> String {
        let m = M[num/1000]
        let c = C[(num%1000)/100]
        let x = X[(num%100)/10]
        let i = I[num%10]
        return m + c + x + i
    }
}

