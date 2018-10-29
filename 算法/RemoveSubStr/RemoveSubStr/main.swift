//
//  main.swift
//  RemoveSubStr
//
//  Created by 伯驹 黄 on 2017/6/2.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

let str = "They are students."
let target = "aeiou"

let competion = "Thy r stdnts."

func removeString(_ str: String, target: String) {
    var dict: [String: Int] = [:]

    for c in target.characters {
        dict["\(c)"] = 1
    }

    var newStr = ""

    for c in str.characters {
        if dict["\(c)"] == nil {
            newStr.append(c)
        }
    }
    print(newStr)
}

removeString(str, target: target)
