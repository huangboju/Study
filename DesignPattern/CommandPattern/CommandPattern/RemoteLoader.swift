//
//  RemoteLoader.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class RemoteLoader {

    var completedCommands: [CommandInterface] = []

    init(remoteControl: RemoteControl) {

        let light = Light()
        let lightOn = LightOnCommand(light: light)
        let lightOff = LightOffCommand(light: light)

        remoteControl.setCommand(with: 0, onCommand: lightOn, offCommand: lightOff)

        let player = CDPlayer()
        let playerOn = CDPlayerOnCommand(light: player)
        let playerOff = CDPlayerOffCommand(light: player)

        remoteControl.setCommand(with: 1, onCommand: playerOn, offCommand: playerOff)

        let onCommands: [CommandInterface] = [lightOn, playerOn]
        let offCommands: [CommandInterface] = [lightOff, playerOff]

        let onMacro = MacroCommand(commands: onCommands)
        let offMacro = MacroCommand(commands: offCommands)

        remoteControl.setCommand(with: 2, onCommand: onMacro, offCommand: offMacro)

        // 序列化命令对象，然后保存
        completedCommands = [
            lightOn,
            lightOff,
            playerOn,
            playerOff,
            onMacro,
            offMacro,
        ]

        //        let data1 = NSKeyedArchiver.archivedData(withRootObject: completedCommands)
        //        UserDefaults.standard.set(data1, forKey: "serialCommands")
        //        UserDefaults.standard.synchronize()
    }
}
