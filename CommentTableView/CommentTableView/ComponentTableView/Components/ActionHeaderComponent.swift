//
//  ActionHeaderComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

protocol ActionHeaderComponentDelegate: TableComponentDelegate {
    func tableComponent(_ component: TableComponent, didTapActionButton button: UIButton)
}

extension ActionHeaderComponentDelegate {
    func tableComponent(_ component: TableComponent, didTapActionButton button: UIButton) {}
}

class ActionHeaderComponent: HeaderComponent {
    var actionButton: UIButton? {
        set {
            accessoryView = actionButton
        }
        get {
            if accessoryView == nil {

                let button = UIButton(type: .custom)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
                button.setTitleColor(button.tintColor, for: .normal)
                button.addTarget(self, action: #selector(onActionButton), for: .touchUpInside)

                accessoryView = button
            }
            return accessoryView as? UIButton
        }
    }

    var actionTitle: String? {
        didSet {
            if actionTitle != oldValue {
                actionButton?.setTitle(actionTitle, for: .normal)
                actionButton?.sizeToFit()
            }
        }
    }

    @objc func onActionButton(_ sender: UIButton) {
        (delegate as? ActionHeaderComponentDelegate)?.tableComponent(self, didTapActionButton: sender)
    }
}
