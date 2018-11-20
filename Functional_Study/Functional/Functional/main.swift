//
//  Position.swift
//  Functional
//
//  Created by 伯驹 黄 on 2016/10/18.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

typealias Distance = Double

struct Position {
    var x: Double
    var y: Double
}

extension Position {
    func within(range: Distance) -> Bool {
        return sqrt(x * x + y * y) <= range
    }
}

struct Ship {
    var position: Position
    var firingRange: Distance
    var unsafeRange: Distance
}

struct Region1 {
    let lookup: (Position) -> Bool
}


extension Region1 {
    static  func circle(_ distance: Distance) -> Region1 {
        return Region1(lookup: { $0.length <= distance })
    }

    static func circle(_ distance: Distance, center: Position) -> Region1 {
        return Region1(lookup: { $0.minus(center).length <= distance })
    }

    func shift(by offset: Position) -> Region1 {
        return Region1(lookup: { self.lookup($0.minus(offset)) })
    }

    func invert() -> Region1 {
        return Region1(lookup: { !self.lookup($0) })
    }

    func intersect(_ other: Region1) -> Region1 {
        return Region1(lookup: { self.lookup($0) && other.lookup($0) })
    }

    func union(_ other: Region1) -> Region1 {
        return Region1(lookup: { self.lookup($0) || other.lookup($0) })
    }

    func subtract(_ region: Region1) -> Region1 {
        return intersect(region.invert())
    }
}



extension Ship {
    func canEngage(ship target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <=  firingRange
    }
}

extension Ship {
    func canSafelyEngage(ship target: Ship) -> Bool {
        let dx = target.position.x - position.x
        let dy = target.position.y - position.y
        let targetDistance = sqrt(dx * dx + dy * dy)
        return targetDistance <=  firingRange && targetDistance > unsafeRange
    }
}


extension Ship {
    func canSafelyEngage(ship target: Ship, friendly: Ship) -> Bool {
        let targetDistance = target.position.minus(position).length
        let friendlyDistance = friendly.position.minus(target.position).length
        return targetDistance <= firingRange
            && targetDistance > unsafeRange && (friendlyDistance > unsafeRange)
    }
}


extension Position {
    func minus(_ p: Position) -> Position {
        return Position(x: x - p.x, y: y - p.y)
    }
    var length: Double {
        return sqrt(x * x + y * y)
    }
}





typealias Region = (Position) -> Bool

func circle(radius: Distance) -> Region {
    return { point in point.length <= radius }
}

func circle2(radius: Distance, center: Position) -> Region {
    return { point in point.minus(center).length <= radius }
}

func shift(_ region: @escaping Region, by offset: Position) -> Region {
    return { point in region(point.minus(offset)) }
}

func invert(_ region: @escaping Region) -> Region {
    return { point in !region(point) }
}


func intersect(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return { point in region(point) && other(point) }
}
func union(_ region: @escaping Region, with other: @escaping Region) -> Region {
    return { point in region(point) || other(point) }
}


func subtract(_ region: @escaping Region, from original: @escaping Region) -> Region {
    return intersect(original , with: invert(region))
}


extension Ship {
    func canSafelyEngage1(ship target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = subtract(circle(radius: unsafeRange), from: circle(radius:  firingRange))
        let firingRegion = shift(rangeRegion, by: position)
        let friendlyRegion = shift(circle(radius: unsafeRange), by: friendly.position)
        let resultRegion = subtract(friendlyRegion, from:  firingRegion)
        return resultRegion(target.position)
    }
    
    func canSafelyEngage2(ship target: Ship, friendly: Ship) -> Bool {
        let rangeRegion = Region1.circle(firingRange).subtract(Region1.circle(unsafeRange))
        let firingRegion = rangeRegion.shift(by: position)
        let friendlyRegion = Region1.circle(unsafeRange).shift(by: friendly.position)
        let resultRegion = firingRegion.subtract(friendlyRegion)
        return resultRegion.lookup(target.position)
    }
}
