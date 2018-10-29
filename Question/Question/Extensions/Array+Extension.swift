//
//  Array+Extension.swift
//  Question
//
//  Created by 泽i on 2017/7/8.
//  Copyright © 2017年 huangboju. All rights reserved.
//

extension Array {
    mutating func random() {
        for _ in 0 ..< count {
            let m = Int(arc4random_uniform(UInt32(count)))
            let n = Int(arc4random_uniform(UInt32(count)))
            guard m != n  else { continue }
            swap(&self[m], &self[n])
        }
    }
}
