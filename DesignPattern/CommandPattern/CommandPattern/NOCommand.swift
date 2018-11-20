//
//  NOCommand.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class NOCommand: CommandInterface {
    func execute() {
        NSLog("该插槽没有安装命令")
    }

    func undo() {
        NSLog("命令被撤销")
    }
}
