//
//  UIWindow+Extension.swift
//  Libertine
//
//  Created by 伯驹 黄 on 2017/5/22.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewController(from: rootViewController)
    }

    public static func getVisibleViewController(from vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewController(from: nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewController(from: tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewController(from: pvc)
            } else {
                return vc
            }
        }
    }
}
