//
//  main.swift
//  CommandPattern
//
//  Created by 伯驹 黄 on 2017/1/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

let remote = RemoteControl()
let loader = RemoteLoader(remoteControl: remote)
// 测试每个按钮的命令
remote.onButtonClick(with: 0)
remote.offButtonClick(with: 0)
remote.onButtonClick(with: 1)
remote.offButtonClick(with: 1)

// 测试宏命令
remote.onButtonClick(with: 2)
remote.offButtonClick(with: 2)
