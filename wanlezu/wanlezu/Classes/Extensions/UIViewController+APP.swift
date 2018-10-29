//
//  UIViewController+APP.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/15.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import PromiseKit

enum NotificationName: String {
    case phoneNumber = "phone_number"
}

enum AlertError: Error {
    case cancelled
}

extension UIViewController {
    func addObserver(with selector: Selector, name: NotificationName, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }

    func postNotification(name: NotificationName, object: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }

    @discardableResult
    func showAlert(title: String? = nil, message: String?, cancleAction: UIAlertAction? = nil, handle: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "确定", style: .default, handler: handle)
        alert.addAction(ok)
        if let cancleAction = cancleAction {
            alert.addAction(cancleAction)
        }
        present(alert, animated: true, completion: nil)
    }
}
