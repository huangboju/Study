//
//  main.swift
//  Factory
//
//  Created by 伯驹 黄 on 2017/1/18.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

protocol Cpu {
    func installCpu()
}

protocol Factory {
    func createCpu(with type: NSInteger) -> Cpu?
}

class InterCpu753: Cpu {
    func installCpu() {
        print("\(self)")
    }
}

class InterCpu1179: Cpu {
    func installCpu() {
        print("\(self)")
    }
}

class IntelFactory: Factory {
    func createCpu(with type: NSInteger) -> Cpu? {
        var cpu: Cpu?
        if type == 753 {
            cpu = InterCpu753()
        } else {
            cpu = InterCpu1179()
        }
        return cpu
    }
}

class AppleCpu1179: Cpu {
    func installCpu() {
        print("\(self)")
    }
}

class AppleCpu753: Cpu {
    func installCpu() {
        print("\(self)")
    }
}

class AppleFactory: Factory {
    func createCpu(with type: NSInteger) -> Cpu? {
        var cpu: Cpu?
        if type == 753 {
            cpu = AppleCpu753()
        } else {
            cpu = AppleCpu1179()
        }
        return cpu
    }
}

class AMDCpu1179: Cpu {
    func installCpu() {
        print("\(self)")
    }
}

class AMDCpu753: Cpu {
    func installCpu() {
        print("\(self)")
    }
}

class AMDFactory: Factory {
    func createCpu(with type: NSInteger) -> Cpu? {
        var cpu: Cpu?
        if type == 753 {
            cpu = AMDCpu753()
        } else {
            cpu = AMDCpu1179()
        }
        return cpu
    }
}

var factory: Factory?
factory = IntelFactory()
let cpu1 = factory?.createCpu(with: 753)
cpu1?.installCpu()
let cpu2 = factory?.createCpu(with: 1179)
cpu2?.installCpu()

factory = AMDFactory()
let cpu3 = factory?.createCpu(with: 753)
cpu3?.installCpu()
let cpu4 = factory?.createCpu(with: 1179)
cpu4?.installCpu()
