//
//  main.swift
//  Decorator
//
//  Created by 伯驹 黄 on 2017/1/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

protocol Component {
    func calculateSalary(monthSales: Int, sumSales: Int) -> Double
}

class ConcreteComponent: Component {
    func calculateSalary(monthSales _: Int, sumSales _: Int) -> Double {
        return 8000
    }
}

class Decorator: Component {

    var component: Component?

    init(component: Component) {
        self.component = component
    }

    func calculateSalary(monthSales: Int, sumSales: Int) -> Double {
        return component!.calculateSalary(monthSales: monthSales, sumSales: sumSales)
    }
}

class MonthBonusDecorator: Decorator {
    override func calculateSalary(monthSales: Int, sumSales: Int) -> Double {
        let salary = component!.calculateSalary(monthSales: monthSales, sumSales: sumSales)
        let bonus = Double(monthSales) * 0.03
        print("当月销售奖金：\(bonus)")
        return salary + bonus
    }
}

class SumBonusDecatorator: Decorator {
    override func calculateSalary(monthSales: Int, sumSales: Int) -> Double {
        let salary = component!.calculateSalary(monthSales: monthSales, sumSales: sumSales)
        let bonus = Double(sumSales) * 0.01
        print("累积销售奖金：\(bonus)")
        return salary + bonus
    }
}

class GroupBonusDecorator: Decorator {
    override func calculateSalary(monthSales: Int, sumSales: Int) -> Double {
        let salary = component!.calculateSalary(monthSales: monthSales, sumSales: sumSales)
        let bonus = 100_000 * 0.01
        print("累积销售奖金：\(bonus)")
        return salary + bonus
    }
}

let c1 = ConcreteComponent()

// 装饰器
let d1 = MonthBonusDecorator(component: c1)
let d2 = SumBonusDecatorator(component: d1)
let salary1 = d2.calculateSalary(monthSales: 10000, sumSales: 12212)
NSLog("\n奖金组合方式：当月销售奖金 + 累积销售奖金 \n 总工资 = \(salary1)")

NSLog("\n=============================================================================")

let d3 = MonthBonusDecorator(component: c1)
let d4 = SumBonusDecatorator(component: d3)
let d5 = GroupBonusDecorator(component: d4)

let salary2 = d5.calculateSalary(monthSales: 12100, sumSales: 12232)
NSLog("\n奖金组合方式：当月销售奖金 + 累积销售奖金 + 团队奖金 \n 总工资 = \(salary2)")

NSLog("\n=============================================================================")

let d6 = MonthBonusDecorator(component: c1)
let d7 = MonthBonusDecorator(component: d6)

let salary3 = d7.calculateSalary(monthSales: 23111, sumSales: 231_111)
NSLog("\n奖金组合方式：当月销售奖金 + 团队奖金 \n 总工资 = \(salary3)")

print("\n\n\n\n\n\n\n\n")

class Beverage {
    var description: String {
        return ("\(self)".components(separatedBy: ".").last ?? "") + " "
    }

    func cost() -> Double {
        return 0
    }
}

class CondimentDecorator: Beverage {
    var beverage: Beverage!

    init(beverage: Beverage) {
        self.beverage = beverage
    }
}

class Espresso: Beverage {
    override func cost() -> Double {
        return 1.99
    }
}

class HouseBlend: Beverage {
    override func cost() -> Double {
        return 0.89
    }
}

class DarkRoast: Beverage {
    override func cost() -> Double {
        return 0.59
    }
}

class Decat: Beverage {
    override func cost() -> Double {
        return 0.19
    }
}

class Mocha: CondimentDecorator {
    override var description: String {
        return beverage.description + " Mocha"
    }

    override func cost() -> Double {
        return 0.2 + beverage.cost()
    }
}

class Soy: CondimentDecorator {
    override var description: String {
        return beverage.description + " Soy"
    }

    override func cost() -> Double {
        return 0.8 + beverage.cost()
    }
}

class Whip: CondimentDecorator {
    override var description: String {
        return beverage.description + " Whip"
    }

    override func cost() -> Double {
        return 0.5 + beverage.cost()
    }
}

let beverage = Espresso()
print("\(beverage.description) $\(beverage.cost())")

let beverage2 = Whip(beverage: Mocha(beverage: Mocha(beverage: DarkRoast())))

print("\(beverage2.description) $\(beverage2.cost())")

let beverage3 = Whip(beverage: Mocha(beverage: Soy(beverage: HouseBlend())))

print("\(beverage3.description) $\(beverage3.cost())")
