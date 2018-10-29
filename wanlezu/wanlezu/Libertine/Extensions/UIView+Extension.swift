//
//  UIView+Extension.swift
//  Libertine
//
//  Created by 伯驹 黄 on 2017/5/26.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

extension UIView {
    var viewController: UIViewController? {
        var responder: UIResponder? = self
        while !(responder is UIViewController) {
            responder = responder?.next
            if nil == responder {
                break
            }
        }
        return responder as? UIViewController
    }
}
