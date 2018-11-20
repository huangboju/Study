//
//  main.swift
//  CompoundPattern
//
//  Created by 伯驹 黄 on 2017/2/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

protocol QuackObserveable {
    func register(_ observe: AXObserver)
    func notifyObservers()
}

protocol Quackable {
    func quack()
}

class MallardDuck: Quackable {
    func quack() {
        print("Quack")
    }
}

class RedheadDuck: Quackable {
    func quack() {
        print("Quack")
    }
}

class DuckCall: Quackable {
    func quack() {
        print("Kwak")
    }
}

class RubberDuck: Quackable {
    func quack() {
        print("Squeak")
    }
}

class Goose {
    func honk() {
        print("Honk")
    }
}

class GooseAdapter: Quackable {
    var goose: Goose?

    init(goose: Goose) {
        self.goose = goose
    }

    func quack() {
        goose?.honk()
    }
}

class QuackCounter: Quackable {
    var duck: Quackable?
    private(set) static var numberOfQuacks = 0

    init(duck: Quackable) {
        self.duck = duck
    }

    func quack() {
        duck?.quack()
        QuackCounter.numberOfQuacks += 1
    }
}

protocol AbstrctDuckFactory {
    func createMallardDuck() -> Quackable
    func createRedheadDuck() -> Quackable
    func createDuckCall() -> Quackable
    func createRubberDuck() -> Quackable
}

class DuckFactory: AbstrctDuckFactory {
    func createDuckCall() -> Quackable {
        return DuckCall()
    }

    func createRedheadDuck() -> Quackable {
        return RedheadDuck()
    }

    func createMallardDuck() -> Quackable {
        return MallardDuck()
    }

    func createRubberDuck() -> Quackable {
        return RubberDuck()
    }
}

class CountingDuckFactory: AbstrctDuckFactory {
    func createRubberDuck() -> Quackable {
        return QuackCounter(duck: RubberDuck())
    }

    func createDuckCall() -> Quackable {
        return QuackCounter(duck: DuckCall())
    }

    func createRedheadDuck() -> Quackable {
        return QuackCounter(duck: RedheadDuck())
    }

    func createMallardDuck() -> Quackable {
        return QuackCounter(duck: MallardDuck())
    }
}

class Flock: Quackable {
    var quackers: [Quackable] = []

    func add(_ quacker: Quackable) {
        quackers.append(quacker)
    }

    func quack() {
        //        var iterator = quackers.makeIterator()
        //
        //        for quacker in sequence(state: (false, iterator), next: { (state:inout (Bool, IndexingIterator<[Quackable]>)) -> Quackable? in
        //            state.0 = !state.0
        //            return state.1.next()
        //            }) {
        //                quacker.quack()
        //        }

        var iterator = quackers.makeIterator()
        while let quacker = iterator.next() {
            quacker.quack()
        }
    }
}

class DuckSimulator {

    func simulate(duckFactory: AbstrctDuckFactory) {

        let mallardDuck = duckFactory.createMallardDuck()
        let redheadDuck = duckFactory.createRedheadDuck()
        let duckCall = duckFactory.createDuckCall()
        let rubberDuck = duckFactory.createRubberDuck()

        let gooseDuck = GooseAdapter(goose: Goose())

        print("\nDuck Simulator")

        let flockOfDucks = Flock()

        flockOfDucks.add(redheadDuck)
        flockOfDucks.add(mallardDuck)
        flockOfDucks.add(duckCall)
        flockOfDucks.add(rubberDuck)
        flockOfDucks.add(gooseDuck)

        let flockOfMallards = Flock()

        (0 ..< 4).forEach { _ in
            flockOfMallards.add(duckFactory.createMallardDuck())
        }

        flockOfDucks.add(flockOfMallards)

        print("Duck Simulator: While Flock Simulation\n")
        simulate(duck: flockOfDucks)

        print("Duck Simulator: Mallard Flock Simulation\n")
        simulate(duck: flockOfMallards)

        print("The ducks quacked \(QuackCounter.numberOfQuacks) times")
    }

    private func simulate(duck: Quackable) {
        duck.quack()
    }
}

let duckSimulator = DuckSimulator()
let duckFactory = CountingDuckFactory()
duckSimulator.simulate(duckFactory: duckFactory)
