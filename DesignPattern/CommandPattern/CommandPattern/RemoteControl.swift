//
//  RemoteControl.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class RemoteControl {
    var slot: CommandInterface?

    private var onCommands: [CommandInterface] = []
    private var offCommands: [CommandInterface] = []
    private var undoCommand: CommandInterface?
    private var completeCommands: [CommandInterface] = []

    init() {
        let noCommands = NOCommand()
        (0 ..< 4).forEach { _ in
            self.offCommands.append(noCommands)
            self.onCommands.append(noCommands)
        }
    }

    func onButtonClick(with slot: Int) {
        let item = onCommands[slot]
        item.execute()
        undoCommand = item
        completeCommands.append(item)
    }

    func offButtonClick(with slot: Int) {
        let item = offCommands[slot]
        item.execute()
        undoCommand = item
        completeCommands.append(item)
    }

    func undoButtonClick() {
        undoCommand?.undo()
    }

    func undoAllOperation() {
        completeCommands.forEach { $0.undo() }
    }

    func setCommand(with slot: Int, onCommand: CommandInterface, offCommand: CommandInterface) {
        onCommands[slot] = onCommand
        offCommands[slot] = offCommand
    }
}
