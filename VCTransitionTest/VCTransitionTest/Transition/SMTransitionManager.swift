//
//  SMTransitionManager.swift
//  VCTransitionTest
//
//  Created by 伯驹 黄 on 2016/10/28.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

enum SMTransitionStyle {
    case alert
}

class SMTransitionManager: NSObject, UIViewControllerTransitioningDelegate {
    var presentStyle: SMTransitionStyle?

    func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch presentStyle! {
        case .alert:
            return SMAlertModelAnnimation()
        }
    }
}
