//
//  main.swift
//  Memento
//
//  Created by 伯驹 黄 on 2017/2/27.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

typealias Memento = NSDictionary

protocol MementoConvertible {
    var memento: Memento { get }
    init?(memento: Memento)
}

struct GameState: MementoConvertible {

    private struct Keys {
        static let chapter = "com.valve.halflife.chapter"
        static let weapon = "com.valve.halflife.weapon"
    }

    var chapter: String
    var weapon: String

    init(chapter: String, weapon: String) {
        self.chapter = chapter
        self.weapon = weapon
    }

    init?(memento: Memento) {
        guard let mementoChapter = memento[Keys.chapter] as? String,
            let mementoWeapon = memento[Keys.weapon] as? String else {
            return nil
        }

        chapter = mementoChapter
        weapon = mementoWeapon
    }

    var memento: Memento {
        return [Keys.chapter: chapter, Keys.weapon: weapon]
    }
}

enum CheckPoint {
    static func save(_ state: MementoConvertible, saveName: String) {
        let defaults = UserDefaults.standard
        defaults.set(state.memento, forKey: saveName)
        defaults.synchronize()
    }

    static func restore(saveName: String) -> Memento? {
        let defaults = UserDefaults.standard

        return defaults.object(forKey: saveName) as? Memento
    }
}

var gameState = GameState(chapter: "Black Mesa Inbound", weapon: "Crowbar")

gameState.chapter = "Anomalous Materials"
gameState.weapon = "Glock 17"
CheckPoint.save(gameState, saveName: "gameState1")

gameState.chapter = "Unforeseen Consequences"
gameState.weapon = "MP5"
CheckPoint.save(gameState, saveName: "gameState2")

gameState.chapter = "Office Complex"
gameState.weapon = "Crossbow"
CheckPoint.save(gameState, saveName: "gameState3")

if let memento = CheckPoint.restore(saveName: "gameState1") {
    let finalState = GameState(memento: memento)
    dump(finalState)
}
