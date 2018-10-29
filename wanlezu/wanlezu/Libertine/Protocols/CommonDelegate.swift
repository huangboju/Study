//
//  CommonDelegate.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

// 让BaseController和GroupedController同一处理

protocol CommonDelegate: class {
    func didInitialized()

    func processMemoryWarning()
    
    func removeObserver()

    /**
     *  负责初始化和设置controller里面的view，也就是self.view的subView。目的在于分类代码，所以与view初始化的相关代码都写在这里。
     *
     *  @warning initSubviews只负责subviews的init，不负责布局。布局相关的代码应该写在 <b>viewDidLayoutSubviews</b>
     */
    func initSubviews()
}

extension CommonDelegate where Self: UIViewController {
    func didInitialized() {

        title = "\(classForCoder)".toSnakecaseStr
    }

    func processMemoryWarning() {
        print("⚠️⚠️⚠️ \(classForCoder)  did receive memory warning")
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
}
