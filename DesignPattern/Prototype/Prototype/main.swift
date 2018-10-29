//
//  main.swift
//  Prototype
//
//  Created by 伯驹 黄 on 2017/2/27.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class ChungasRevengeDisplay {
    var name: String?
    let font: String

    init(font: String) {
        self.font = font
    }

    func clone() -> ChungasRevengeDisplay {
        return ChungasRevengeDisplay(font: font)
    }
}

let Prototype = ChungasRevengeDisplay(font: "GotanProject")

let Philippe = Prototype.clone()
Philippe.name = "Philippe"

let Christoph = Prototype.clone()
Christoph.name = "Christoph"

let Eduardo = Prototype.clone()
Eduardo.name = "Eduardo"
