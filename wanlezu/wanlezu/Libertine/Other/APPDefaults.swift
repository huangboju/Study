//
//  APPDefaults.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import SwiftyUserDefaults

let APPDefaults = Defaults

extension DefaultsKeys {
    static let developer = DefaultsKey<Bool>("developer")
    static let isFirstOpen = DefaultsKey<Bool>("isFirstOpen")
}
