//
//  ViewController.swift
//  Dynamics
//
//  Created by 伯驹 黄 on 2016/10/31.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var storeAnimator: UIDynamicAnimator = {
        let animator = UIDynamicAnimator(referenceView: self.view)
        return animator
    }()

    private lazy var aView: UIView = {
        let aView = UIView(frame: CGRect(x: 100, y: 250, width: 100, height: 100))
        aView.backgroundColor = UIColor.lightGray
        return aView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(aView)
//                freeFall()
//                collision()
//                snap()
//                attachment()
        push()
    }

    func collision() {

        let gravityBeahvior = UIGravityBehavior(items: [aView])
        storeAnimator.addBehavior(gravityBeahvior)

        let collisionBehavior = UICollisionBehavior(items: [aView])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        storeAnimator.addBehavior(collisionBehavior)
    }

    func freeFall() {
        let gravityBeahvior = UIGravityBehavior(items: [aView])
        storeAnimator.addBehavior(gravityBeahvior)
    }

    func snap() {
        let gravityBeahvior = UISnapBehavior(item: aView, snapTo: view.center)
        gravityBeahvior.damping = 0.5
        storeAnimator.addBehavior(gravityBeahvior)
    }

    /*
     initWithItem:attachedToAnchor: － 初始化吸附到锚点
     initWithItem:attachedToItem: － 初始化吸附到item
     anchorPoint － 锚点
     damping － 阻尼（阻力大小）
     frequency － 震荡频率
     length － 吸附的两个点之间的距离（锚点和Item或者Item之间）

     原文链接：http://www.jianshu.com/p/9272b8e023cb
     */

    // 摇摆
    func attachment() {
        let attachBeahavior = UIAttachmentBehavior(item: aView, attachedToAnchor: CGPoint(x: view.frame.midX, y: 114))
        let gravityBehavior = UIGravityBehavior(items: [aView])
        storeAnimator.addBehavior(attachBeahavior)
        storeAnimator.addBehavior(gravityBehavior)
    }

    func push() {
        let push = UIPushBehavior(items: [aView], mode: .instantaneous)
        push.pushDirection = CGVector(dx: 0, dy: -5)
        push.magnitude = 1
        let itemBehavior = UIDynamicItemBehavior(items: [aView])
        itemBehavior.resistance = 0.8
//        storeAnimator.addBehavior(itemBehavior)
        storeAnimator.addBehavior(push)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollisionBehaviorDelegate {
    func collisionBehavior(_: UICollisionBehavior, endedContactFor item1: UIDynamicItem, with item2: UIDynamicItem) {
        print(item1, item2, "aaaa")
    }
}
