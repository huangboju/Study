//
//  main.swift
//  Duck
//
//  Created by 伯驹 黄 on 2017/1/14.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

protocol FlyBehavior {
    func fly()
}

protocol QuackBehavior {
    func quack()
}

class FlyWithWings: FlyBehavior {
    func fly() {
        print("fly FlyWithWings")
    }
}

class FlyNoWay: FlyBehavior {
    func fly() {
        print("I can't fly")
    }
}

class Quack: QuackBehavior {
    func quack() {
        print("Quack")
    }
}

class MuteQuack: QuackBehavior {
    func quack() {
        print("quack MuteQuack")
    }
}

class Squeak: QuackBehavior {
    func quack() {
        print("Squeak")
    }
}

class Duck {
    private let flyBehavior: FlyBehavior
    private let quackBehavior: QuackBehavior

    init(flyBehavior: FlyBehavior, quackBehavior: QuackBehavior) {
        self.flyBehavior = flyBehavior
        self.quackBehavior = quackBehavior
    }

    func performQuack() {
        quackBehavior.quack()
    }

    func performFly() {
        flyBehavior.fly()
    }
}

let mallarDuck = Duck(flyBehavior: FlyWithWings(), quackBehavior: Quack())

mallarDuck.performFly()
mallarDuck.performQuack()
