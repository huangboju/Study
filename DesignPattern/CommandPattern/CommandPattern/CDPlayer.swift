//
//  CDPlayer.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class CDPlayer {
    func on() {
        print("CD播放器被打开")
    }

    func off() {
        print("CD播放器被关闭")
    }

    func set(volume: Int) {
        print("设置声音大小为：\(volume)")
    }
}
