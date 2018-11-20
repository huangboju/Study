//
//  LightOnCommand.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class LightOnCommand: NSObject, CommandInterface {

    var light: Light?

    init(light: Light) {
        super.init()
        self.light = light
    }

    func execute() {
        light?.on()
    }

    func undo() {
        light?.off()
    }
}
