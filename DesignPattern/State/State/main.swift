//
//  main.swift
//  State
//
//  Created by 伯驹 黄 on 2017/5/18.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

protocol State: class {
    func insertQuarter()
    
    func ejectQuarter()
    
    func tumCrank()
    
    func dispense()
}

class SoldState: State {
    private unowned var gumballMachine: GumballMachiner

    init(gumballMachine: GumballMachiner) {
        self.gumballMachine = gumballMachine
    }

    func dispense() {
        gumballMachine.releaseBall()
        if gumballMachine.count > 0 {
            gumballMachine.state = gumballMachine.noQuarterState
        } else {
            print("Oops, out of gumballs!")
        }
    }

    func tumCrank() {
        print("Turning twice doesn't get you another gumball!")
    }
    
    func ejectQuarter() {
        print("Sorry, you already turned the crank")
    }
    
    func insertQuarter() {
        print("Please wait, we're already giving you a gumball")
    }
}


class SoldOutState: State {
    private unowned var gumballMachine: GumballMachiner

    init(gumballMachine: GumballMachiner) {
        self.gumballMachine = gumballMachine
    }

    func dispense() {
        print("No gumball dispensed")
    }
    
    func tumCrank() {
        print("Turning twice doesn't get you another gumball!")
    }
    
    func ejectQuarter() {
        print("You can't eject, you haven't inserted a quarter yet")
    }
    
    func insertQuarter() {
        print("You can't insert a quarter, the machine is sold out")
    }
}


class NoQuarterState: State {
    private unowned var gumballMachine: GumballMachiner
    
    init(gumballMachine: GumballMachiner) {
        self.gumballMachine = gumballMachine
    }

    func dispense() {
        print("You need to pay first")
    }
    
    func tumCrank() {
        print("You turned, but there's no quarter")
    }
    
    func ejectQuarter() {
        print("You haven't inserted a quarter")
    }
    
    func insertQuarter() {
        print("Yes inserted a quarter")
        
    }
}


class HasQuarterState: State {
    private unowned var gumballMachine: GumballMachiner

    init(gumballMachine: GumballMachiner) {
        self.gumballMachine = gumballMachine
    }

    func dispense() {
        print("No gumball dispensed")
    }

    func tumCrank() {
        print("You turned ...")
        gumballMachine.state = gumballMachine.soldOutState
    }
    
    func ejectQuarter() {
        print("Quarter returned")
        let winner = arc4random_uniform(10)
        if winner == 0 && gumballMachine.count > 1 {
            gumballMachine.state = gumballMachine.winnerState
        } else {
            gumballMachine.state = gumballMachine.soldState
        }
    }
    
    func insertQuarter() {
        print("You can't insert another quarter")
    }
}



class WinnerState: State {
    private unowned var gumballMachine: GumballMachiner

    init(gumballMachine: GumballMachiner) {
        self.gumballMachine = gumballMachine
    }

    func dispense() {
        print("YOU'RE A WINNER! You get two gumballs for your quarter")
        gumballMachine.releaseBall()
        if gumballMachine.count == 0 {
            gumballMachine.state = gumballMachine.soldOutState
        } else {
            gumballMachine.releaseBall()
            if gumballMachine.count > 0 {
                gumballMachine.state = gumballMachine.noQuarterState
            } else {
                print("Oops, out of gumballs!")
                gumballMachine.state = gumballMachine.soldOutState
            }
        }
    }
    
    func tumCrank() {
        print("Turning twice doesn't get you another gumball!")
    }
    
    func ejectQuarter() {
        print("Sorry, you already turned the crank")
    }
    
    func insertQuarter() {
        print("Please wait, we're already giving you a gumball")
    }
}


class GumballMachiner {
    var soldOutState: State?
    var noQuarterState: State?
    var hasQuarterState: State?
    var soldState: State?
    var winnerState: State?

    var state: State?
    var count = 0

    init(numberGumballs: Int) {
        soldOutState = SoldOutState(gumballMachine: self)
        noQuarterState = NoQuarterState(gumballMachine: self)
        hasQuarterState = HasQuarterState(gumballMachine: self)
        soldState = SoldState(gumballMachine: self)
        winnerState = WinnerState(gumballMachine: self)

        if numberGumballs > 0 {
            state = hasQuarterState
        }
    }

    func inserQuarter() {
        state?.insertQuarter()
    }

    func ejectQuarter() {
        state?.ejectQuarter()
    }

    func turnCrank() {
        state?.tumCrank()
    }

    func releaseBall() {
        print("A gumball comes rolling out the slot")
        if count != 0 {
            count -= 1
        }
    }

    deinit {
        print("==================")
    }
}



var gumballMachine:  GumballMachiner? = GumballMachiner(numberGumballs: 5)

print(gumballMachine)
gumballMachine?.inserQuarter()
gumballMachine?.turnCrank()


print(gumballMachine)

gumballMachine?.inserQuarter()
gumballMachine?.turnCrank()
gumballMachine?.inserQuarter()
gumballMachine?.turnCrank()

print(gumballMachine)

gumballMachine = nil
