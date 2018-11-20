//
//  UISetable.swift
//  RunTime
//
//  Created by 伯驹 黄 on 2016/11/18.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

protocol UISetable: class {
    var textLabel: UILabel? { set get }
}

extension UISetable where Self: UIViewController {
    func creatingTextLabel(_ str: String) {
        view.backgroundColor = .white

        textLabel = UILabel(frame: CGRect(x: 15, y: 64, width: view.frame.width - 30, height: 0))
        textLabel?.numberOfLines = 3
        textLabel?.text = str
        textLabel?.sizeToFit()
        view.addSubview(textLabel!)
    }
}
