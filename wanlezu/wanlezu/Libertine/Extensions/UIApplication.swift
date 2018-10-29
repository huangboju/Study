//
//  UIApplication.swift
//  Libertine
//
//  Created by 伯驹 黄 on 2017/3/8.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

extension UIApplication {
    public static var visibleViewController: UIViewController? {
        return UIApplication.getVisibleViewController(from: UIApplication.shared.keyWindow?.rootViewController)
    }

    public static func getVisibleViewController(from vc: UIViewController?) -> UIViewController? {

        if let nav = vc as? UINavigationController {
            return getVisibleViewController(from: nav.visibleViewController)
        } else if let tab = vc as? UITabBarController {
            return getVisibleViewController(from: tab.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return getVisibleViewController(from: pvc)
            } else {
                return vc
            }
        }
    }
}
