//
//  UIView+Extension.swift
//  Question
//
//  Created by 泽i on 2017/7/8.
//  Copyright © 2017年 huangboju. All rights reserved.
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
