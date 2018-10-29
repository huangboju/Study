//
//  AppConfigurationTemplate.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

struct AppConfigurationTemplate {
    static func setupConfigurationTemplate() {
        // 在这里配置需要的颜色
        APPConfigCenter.gray = UIColor(hex: 0x8E8E93)
        APPConfigCenter.white = UIColor(hex: 0xFFFFFF)
        APPConfigCenter.black = UIColor(hex: 0x333333)
        APPConfigCenter.app = UIColor(hex: 0x1E90FF)
        APPConfigCenter.background = UIColor(hex: 0xFFFFFF)

        // === 导航栏和tabbar === //
        APPConfigCenter.navBarTintColor = APPConfigCenter.app
        APPConfigCenter.tabBarTintColor = APPConfigCenter.app
    }
}
