//
//  File.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class LightOffCommand: NSObject, CommandInterface {

    var light: Light?

    init(light: Light) {
        super.init()
        self.light = light
    }

    func execute() {
        light?.off()
    }

    func undo() {
        light?.on()
    }
}
