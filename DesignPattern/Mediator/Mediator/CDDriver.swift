//
//  CDDriver.swift
//  Mediator
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

class CDDriver {
    func readCD() {
        let data = "BBC地球探索之旅"
        MainBoard.shared.handle(data: data, dataSource: self)
    }
}
