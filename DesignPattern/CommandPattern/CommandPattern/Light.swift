//
//  Light.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class Light: NSObject {
    func on() {
        print("灯被打开")
    }

    func off() {
        print("灯被关闭")
    }
}
