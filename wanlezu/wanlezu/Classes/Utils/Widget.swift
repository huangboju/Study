//
//  Widget.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/15.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import TTTAttributedLabel

struct Widget {

    /// tableView 上的按钮
    static func generateFooterButton(with title: String?, target: Any?, action: Selector) -> UIView {
        let button = generateDarkButton(with: title, target: target, action: action)
        let footerView = UIView(frame: CGSize(width: SCREEN_WIDTH, height: CELL_HEIGHT).rect)
        footerView.addSubview(button)
        return footerView
    }

    /// 实心按钮
    static func generateDarkButton(with title: String?, target: Any?, action: Selector) -> QMUIButton {
        let button = QMUIButton(frame: CGRect(x: PADDING, y: 0, width: BODY_WIDTH, height: CELL_HEIGHT))
        button.adjustsButtonWhenHighlighted = true
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = APPConfigCenter.app
        button.highlightedBackgroundColor = UIColor(r: 0, g: 168, b: 225) // 高亮时的背景色
        button.layer.cornerRadius = 4
        return button
    }

    /// 空心带描边按钮
    static func generateBorderedButton(with title: String?, target: Any?, action: Selector) -> QMUIButton {
        let button = QMUIButton(frame: CGRect(x: PADDING, y: 0, width: BODY_WIDTH, height: CELL_HEIGHT))
        button.setTitle(title, for: .normal)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor(r: 235, g: 249, b: 255)
        button.highlightedBackgroundColor = UIColor(r: 211, g: 239, b: 252) // 高亮时的背景色
        button.layer.borderColor = UIColor(r: 142, g: 219, b: 249).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 4
        button.highlightedBorderColor = UIColor(r: 0, g: 168, b: 225) // 高亮时的边框颜色
        return button
    }

    static func createRightBtn(with textField: UITextField, width: CGFloat, title: String?, target: Any?, action: Selector) -> UIButton {
        let button = UIButton(frame: CGSize(width: width, height: 30).rect)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont
        button.addTarget(target, action: action, for: .touchUpInside)
        button.setTitleColor(UIColor(hex: 0x333333), for: .normal)
        button.layer.borderWidth = 0.5
        button.layer.cornerRadius = 3
        button.layer.borderColor = APPConfigCenter.gray.cgColor
        textField.rightView = button
        textField.rightViewMode = .always
        return button
    }

    /// 链接跳转label, 子串为key，url为value
    static func createLinkLabel(frame: CGRect, text: String, dict: [String: String]) -> TTTAttributedLabel {
        let label = TTTAttributedLabel(frame: frame)
        label.font = UIFont.smallSystemFont
        label.numberOfLines = 0
        label.linkAttributes = [
            NSForegroundColorAttributeName: APPConfigCenter.app,
            NSUnderlineStyleAttributeName: NSNumber(value: false)
        ]
        for (key, url) in dict {
            let range = text.range(of: key)
            label.addLink(to: URL(string: url), with: range)
        }
        return label
    }
}
