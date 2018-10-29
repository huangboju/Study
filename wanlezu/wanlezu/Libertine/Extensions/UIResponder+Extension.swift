//
//  UIResponder+Extension.swift
//  Router
//
//  Created by 伯驹 黄 on 2016/12/7.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

extension UIResponder {

    struct Keys {
        static let controller = "controller"
        static let tag = "tag"
    }

    struct EventName {
        static let segueEvent = "segueEvent"
    }

    func router(with eventName: String, userInfo: [String: Any]) {
        if let next = next {
            next.router(with: eventName, userInfo: userInfo)
        }
    }
}
