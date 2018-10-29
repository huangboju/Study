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
        APPConfigCenter.app = UIColor(hex: 0x1E90FF)
        APPConfigCenter.highlight = UIColor(hex: 0x00DFF9)

        // === 导航栏和tabbar === //
        APPConfigCenter.navBarTintColor = APPConfigCenter.app
        APPConfigCenter.hiddenNaBarBackTitle = true
        APPConfigCenter.tabBarTintColor = APPConfigCenter.highlight
    }
}
