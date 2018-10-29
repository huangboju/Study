//
//  UIEdgeInsets+Extension.swift
//  Libertine
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

extension UIEdgeInsets {
    /// 获取UIEdgeInsets在水平方向上的值
    var horizontalValue: CGFloat {
        return left + right
    }

    /// 获取UIEdgeInsets在垂直方向上的值
    var verticalValue: CGFloat {
        return top + bottom
    }

    /// 将两个UIEdgeInsets合并为一个
    func concat(insets: UIEdgeInsets) -> UIEdgeInsets {
        let top = self.top + insets.top
        let left = self.left + insets.left
        let bottom = self.bottom + insets.bottom
        let right = self.right + insets.right
        return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }

    mutating func setTop(_ top: CGFloat) {
        self.top = flat(top)
    }

    mutating func setLeft(_ left: CGFloat) {
        self.left = flat(left)
    }

    mutating func setBottom(bottom: CGFloat) {
        self.bottom = flat(bottom)
    }

    mutating func setRight(_ right: CGFloat) {
        self.right = flat(right)
    }
}
