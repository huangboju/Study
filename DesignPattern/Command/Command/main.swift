//
//  main.swift
//  Command
//
//  Created by 伯驹 黄 on 2017/2/4.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

protocol Command {
    func execute()
    func undo()
}

protocol Device {
    func on()
    func off()
    var name: String { get }
}

// MARK: - Devices
class Light: Device {
    let name: String

    init(name: String = "") {
        self.name = name
    }

    func on() {
        print("\(name) Light is On")
    }

    func off() {
        print("\(name) Light is Off")
    }
}

class Stereo: Device {
    let name: String

    init(name: String = "") {
        self.name = name
    }

    func on() {
        print("\(name) Stereo is On")
    }

    func off() {
        print("\(name) Stereo is off")
    }

    func setCD() {
        print("\(name) CD is set")
    }

    func setDVD() {
        print("\(name) DVD is set")
    }

    func setRadio() {
        print("\(name) Radio is set")
    }

    func set(volume: Int) {
        print("\(name) Volume is set \(volume)")
    }
}

enum Gear: Int {
    case high, medium, low, off
}

class CeilingFan: Device {
    let name: String

    var speed: Gear = .off
    var count = 3

    init(name: String = "") {
        self.name = name
    }

    func high() {
        count -= 1
        count = max(0, count)
        speed = Gear(rawValue: count) ?? .high
    }
    
    func low() {
        count += 1
        count = min(3, count)
        speed = Gear(rawValue: count) ?? .off
    }

    func off() {
        speed = .off
    }

    func on() {
        print("\(name) CeilingFan is On")
    }
}

class GarageDoor: Device {
    let name: String

    init(name: String = "") {
        self.name = name
    }

    func on() {
        print("GarageDoor is On")
    }

    func off() {
        print("GarageDoor is Off")
    }
}

// MARK: - Commands
class LightOnCommand: Command {

    let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.on()
    }

    func undo() {
        light.off()
    }
}

class LightOffCommand: Command {
    let light: Light

    init(light: Light) {
        self.light = light
    }

    func execute() {
        light.off()
    }

    func undo() {
        light.on()
    }
}

class StereoOnWithCDCommand: Command {
    let stereo: Stereo

    init(stereo: Stereo) {
        self.stereo = stereo
    }

    func execute() {
        stereo.on()
        stereo.setCD()
        stereo.set(volume: 11)
    }

    func undo() {
    }
}

class StereoOffWithCDCommand: Command {
    let stereo: Stereo

    init(stereo: Stereo) {
        self.stereo = stereo
    }

    func execute() {
        stereo.off()
        stereo.setCD()
        stereo.set(volume: 0)
    }

    func undo() {
    }
}

class CeilingFanOnCommand: Command {
    let ceilingFan: CeilingFan

    init(ceilingFan: CeilingFan) {
        self.ceilingFan = ceilingFan
    }

    func execute() {
        ceilingFan.on()
    }

    func undo() {
    }
}

class CeilingFanHighCommand: Command {
    let ceilingFan: CeilingFan

    init(ceilingFan: CeilingFan) {
        self.ceilingFan = ceilingFan
    }

    func execute() {
        ceilingFan.high()
    }

    func undo() {
        ceilingFan.low()
    }
}

class CeilingFanOffCommand: Command {
    let ceilingFan: CeilingFan

    init(ceilingFan: CeilingFan) {
        self.ceilingFan = ceilingFan
    }

    func execute() {
        ceilingFan.off()
    }

    func undo() {
    }
}

class GarageDoorUpCommand: Command {
    let garageDoor: GarageDoor

    init(garageDoor: GarageDoor) {
        self.garageDoor = garageDoor
    }

    func execute() {
        garageDoor.on()
    }

    func undo() {
    }
}

class GarageDoorDownCommand: Command {
    let garageDoor: GarageDoor

    init(garageDoor: GarageDoor) {
        self.garageDoor = garageDoor
    }

    func execute() {
        garageDoor.off()
    }

    func undo() {
    }
}

class MacroCommand: Command {
    var commands: [Command] = []

    init(commands: [Command]) {
        self.commands = commands
    }

    func execute() {
        commands.forEach { $0.execute() }
    }

    func undo() {
        commands.forEach { $0.undo() }
    }
}

class SimpleRemoteControl {
    var slot: Command!

    func set(command: Command) {
        slot = command
    }

    func buttonWasPressed() {
        slot.execute()
    }
}

let remote = SimpleRemoteControl()

let light = Light()
let lightOn = LightOnCommand(light: light)

remote.set(command: lightOn)
remote.buttonWasPressed()

class NoCommand: Command {
    func execute() {
    }

    func undo() {
    }
}

class RemoteControl {
    var onCommands: [Command] = []
    var offCommands: [Command] = []
    var undoCommand: Command!

    init() {
        let noCommand = NoCommand()
        (0 ..< 7).forEach { _ in
            onCommands.append(noCommand)
            offCommands.append(noCommand)
        }
        undoCommand = noCommand
    }

    func setCommand(slot: Int, onCommand: Command, offCommand: Command) {
        onCommands[slot] = onCommand
        offCommands[slot] = offCommand
    }

    func onButtonWasPushed(slot: Int) {
        let command = onCommands[slot]
        command.execute()
        undoCommand = command
    }

    func offButtonWasPushed(slot: Int) {
        let command = offCommands[slot]
        command.execute()
        undoCommand = command
    }

    func undoButtonWasPushed() {
        undoCommand.undo()
    }
}

let livingRoomLight = Light(name: "Living Room")
let kitchenLight = Light(name: "Kitchen")
let ceilingFan = CeilingFan(name: "Living Room")
let garageDoor = GarageDoor()
let stereo = Stereo(name: "Living Room")

let livingRoomLightOn = LightOnCommand(light: livingRoomLight)
let livingRoomLightOff = LightOffCommand(light: livingRoomLight)
let kitchenRoomLightOn = LightOnCommand(light: kitchenLight)
let kitchenRoomLightOff = LightOffCommand(light: kitchenLight)

let ceilingFanOn = CeilingFanOnCommand(ceilingFan: ceilingFan)
let ceilingFanOff = CeilingFanOffCommand(ceilingFan: ceilingFan)
let ceilingHigh = CeilingFanHighCommand(ceilingFan: ceilingFan)

let garageDoorUp = GarageDoorUpCommand(garageDoor: garageDoor)
let garageDoorDown = GarageDoorDownCommand(garageDoor: garageDoor)

let stereoOnWithCD = StereoOnWithCDCommand(stereo: stereo)
let stereoOffWithCD = StereoOffWithCDCommand(stereo: stereo)

let remoteControl = RemoteControl()
remoteControl.setCommand(slot: 0, onCommand: livingRoomLightOn, offCommand: livingRoomLightOff)
remoteControl.setCommand(slot: 1, onCommand: kitchenRoomLightOn, offCommand: kitchenRoomLightOff)
remoteControl.setCommand(slot: 2, onCommand: ceilingFanOn, offCommand: ceilingFanOff)
remoteControl.setCommand(slot: 3, onCommand: stereoOnWithCD, offCommand: stereoOffWithCD)

remoteControl.onButtonWasPushed(slot: 0)
remoteControl.offButtonWasPushed(slot: 0)
remoteControl.undoButtonWasPushed()
remoteControl.onButtonWasPushed(slot: 1)
remoteControl.offButtonWasPushed(slot: 1)
remoteControl.undoButtonWasPushed()
remoteControl.onButtonWasPushed(slot: 2)
remoteControl.offButtonWasPushed(slot: 2)
remoteControl.undoButtonWasPushed()
remoteControl.onButtonWasPushed(slot: 3)
remoteControl.offButtonWasPushed(slot: 3)
remoteControl.undoButtonWasPushed()

let partyOn: [Command] = [livingRoomLightOn, kitchenRoomLightOn, ceilingFanOn]
let partyOff: [Command] = [livingRoomLightOff, kitchenRoomLightOff, ceilingFanOff]
let partyOnMacro = MacroCommand(commands: partyOn)
let partyOffMacro = MacroCommand(commands: partyOff)

remoteControl.setCommand(slot: 6, onCommand: partyOnMacro, offCommand: partyOffMacro)
remoteControl.onButtonWasPushed(slot: 6)
remoteControl.offButtonWasPushed(slot: 6)
