//
//  String+App.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/15.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

enum VerifyType {
    case phoneNumber
    case email
    case address
}

extension String {
    // http://www.jianshu.com/p/a3dd72eadfa3
    func verify(with type: VerifyType) -> Bool {
        switch type {
        case .phoneNumber:
            let pattern = "^1+[3578]+\\d{9}"
            let pred = NSPredicate(format: "SELF MATCHES %@", pattern)
            return pred.evaluate(with: self)
        case .email:
            break
        case .address:
            break
        }
        return false
    }
}
