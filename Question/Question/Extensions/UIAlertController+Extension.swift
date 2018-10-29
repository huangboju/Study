//
//  UIAlertController+Extension.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/18.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

extension UIAlertController {
    @discardableResult
    func action(_ title: String?, style: UIAlertActionStyle = .`default`, _ handle: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let action = UIAlertAction(title: title, style: style, handler: handle)
        addAction(action)
        return self
    }
}
