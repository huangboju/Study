//
//  main.swift
//  HashableTest
//
//  Created by 黄伯驹 on 2017/8/29.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import Foundation

struct MyModel: Hashable {
    let id: Int
    
    var hashValue: Int {
        return id
    }
}

func ==(lhs: MyModel, rhs: MyModel) -> Bool {
    return lhs.hashValue == rhs.hashValue
}


let a = MyModel(id: 124)
let b = MyModel(id: 124)

print(a == b)

