//
//  MainBoard.swift
//  Mediator
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

class MainBoard {

    static let shared = MainBoard()

    private init() {}

    func handle(data: String, dataSource: Any) {
        if dataSource as? CDDriver != nil {
            let cpu = Cpu()
            cpu.execute(data: data)
        } else if dataSource as? Cpu != nil {
            let video = VideoCard()
            video.execute(data: data)
        }
    }
}
