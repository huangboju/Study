//
//  BaseController.swift
//  Question
//
//  Created by 泽i on 2017/7/8.
//  Copyright © 2017年 huangboju. All rights reserved.
//

class BaseController: UIViewController, ObserverPresenter {
    final override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initUI()
    }

    // 子类重写
    open func initUI() {}

    deinit {
        removeObserver()
    }
}

enum NotificationName: String {
    case retry = "retry"
}

protocol ObserverPresenter {
    func addObserver(with selector: Selector, name: NotificationName, object: Any?)

    func postNotification(name: NotificationName, object: Any?)

    func removeObserver()
}

extension ObserverPresenter {
    func addObserver(with selector: Selector, name: NotificationName, object: Any? = nil) {
        NotificationCenter.default.addObserver(self, selector: selector, name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }

    func postNotification(name: NotificationName, object: Any? = nil) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: object)
    }

    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
