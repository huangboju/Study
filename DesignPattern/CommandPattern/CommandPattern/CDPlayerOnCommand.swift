//
//  CDPlayOnCommand.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class CDPlayerOnCommand: NSObject, CommandInterface {
    var player: CDPlayer?

    init(light: CDPlayer) {
        super.init()
        player = light
    }

    func execute() {
        player?.on()
        player?.set(volume: 11)
    }

    func undo() {
        player?.off()
        player?.set(volume: 0)
    }
}
