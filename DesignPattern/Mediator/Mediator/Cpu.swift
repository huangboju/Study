//
//  CPU.swift
//  Mediator
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

class Cpu {
    func execute(data: String) {
        let str = data + "+经过cpu处理"
        MainBoard.shared.handle(data: str, dataSource: self)
    }
}
