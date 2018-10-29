//
//  Me.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Eureka

private typealias Item = (String, String, UIViewController.Type)

class Me: GroupedController {

    override func initForm() {

        let contents: [Item] = [
            ("profile", "个人中心", SignUp.self),
            ("borrowing_orders", "借款订单", SignUp.self),
            ("task", "赚钱任务", SignUp.self),
            ("help", "帮助中心", SignUp.self),
            ("invite", "好友邀请", SignUp.self)
        ]

        let section = Section()
        form +++
            section

        let rows: [BaseRow] = contents.map(creatRow)
        section.append(contentsOf: rows)
    }

    override func initSubviews() {
        // 透明导航栏
        self.navBarBgAlpha = 0

        let headerView = UIView(frame: CGSize(width: SCREEN_WIDTH, height: 120).rect)
        headerView.backgroundColor = UIColor.red
        tableView.tableHeaderView = headerView
    }

    private func creatRow(with item: Item) -> SegueRow {
        return SegueRow {
            $0.tag = item.0
            $0.title = item.1
            $0.controller = SignUp.self
            // 参考 Airbnb
            $0.cell.height = { 75 }
            $0.cell.imageView?.image = UIImage(named: "invite")
        }
    }

    override func router(with eventName: String, userInfo: [String : Any]) {
        guard eventName == EventName.segueEvent else {
            return
        }
        let tag = userInfo[Keys.tag] as? String
        print(tag)
        if let controller = userInfo[Keys.controller] as? UIViewController {
            print(controller)
        }
    }
}
