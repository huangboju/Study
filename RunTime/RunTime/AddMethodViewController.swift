//
//  AddMethodViewController.swift
//  RunTime
//
//  Created by 伯驹 黄 on 2016/11/8.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class AddMethodViewController: UIViewController, UISetable {
    var xiaoMing: Person?

    var textLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        creatingTextLabel("")

        xiaoMing = Person()
        xiaoMing?.englishName = "xiao"
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        answer()
    }

    func answer() {
        let swizzledMethod = class_getInstanceMethod(classForCoder, #selector(guessAnswer))

        let flag = class_addMethod(xiaoMing?.classForCoder, #selector(guess), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

        if flag {
            perform(#selector(guess))
        }
    }

    func guess() {
        print(#function)
    }

    func guessAnswer() {

        NSLog("He is from GuangTong")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// http://nshipster.cn/swift-objc-runtime/

extension UIViewController {
    private struct AssociatedKeys {
        static var DescriptiveName = "nsh_DescriptiveName"
    }

    var descriptiveName: String? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.DescriptiveName) as? String
        }
        set {
            if let newValue = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.DescriptiveName, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }

    static let _onceToken = NSUUID().uuidString

    open override class func initialize() {
        // make sure this isn't a subclass
        if self !== UIViewController.self {
            return
        }

        DispatchQueue.once(token: _onceToken) {
            let originalSelector = #selector(viewWillAppear)
            let swizzledSelector = #selector(nsh_viewWillAppear)

            let originalMethod = class_getInstanceMethod(self, originalSelector)
            let swizzledMethod = class_getInstanceMethod(self, swizzledSelector)

            let didAddMethod = class_addMethod(self, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))

            if didAddMethod {
                class_replaceMethod(self, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
            } else {
                method_exchangeImplementations(originalMethod, swizzledMethod)
            }
        }
    }

    // MARK: - Method Swizzling

    func nsh_viewWillAppear(_ animated: Bool) {
        nsh_viewWillAppear(animated)
        if let name = self.descriptiveName {
            print("viewWillAppear: \(name)")
        } else {
            print("viewWillAppear: \(self)")
        }
    }
}

public extension DispatchQueue {

    private static var _onceTracker = [String]()

    public class func once(token: String, block: () -> Void) {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }

        if _onceTracker.contains(token) {
            return
        }

        _onceTracker.append(token)
        block()
    }
}
