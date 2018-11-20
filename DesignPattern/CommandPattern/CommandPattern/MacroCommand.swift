//
//  MacroCommand.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class MacroCommand: NSObject, CommandInterface {

    var commands: [CommandInterface] = []

    init(commands: [CommandInterface]) {
        super.init()
        self.commands = commands
    }

    func execute() {
        commands.forEach {
            $0.execute()
        }
    }

    func undo() {
        commands.forEach {
            $0.undo()
        }
    }
}
