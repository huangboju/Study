//
//  SMAlertModelAnnimation.swift
//  VCTransitionTest
//
//  Created by 伯驹 黄 on 2016/10/28.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class SMAlertModelAnnimation: NSObject, UIViewControllerAnimatedTransitioning {

    private lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.backgroundColor = UIColor(white: 0, alpha: 0.7)
        coverView.autoresizingMask = [
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin,
            .flexibleTopMargin,
            .flexibleWidth,
            .flexibleHeight,
        ]
        return coverView
    }()

    private var constraints: [NSLayoutConstraint] = []

    func transitionDuration(using _: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView

        guard let toView = transitionContext.viewController(forKey: .to)?.view else { return }
        coverView.frame = containerView.frame
        containerView.addSubview(coverView)
        toView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(toView)
        let containerViewSize = UIScreen.main.bounds.size
        let modelWidth = (containerViewSize.width > containerViewSize.height ? containerViewSize.width : containerViewSize.height) * 0.5
        let modelHeight = (containerViewSize.width < containerViewSize.height ? containerViewSize.width : containerViewSize.height) * 0.8

        let centerY = NSLayoutConstraint(item: toView, attribute: .centerY, relatedBy: .equal, toItem: containerView, attribute: .centerY, multiplier: 1, constant: 0)
        let centerX = NSLayoutConstraint(item: toView, attribute: .centerX, relatedBy: .equal, toItem: containerView, attribute: .centerX, multiplier: 1, constant: 0)
        let modelWidthContraint = NSLayoutConstraint(item: toView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: modelWidth)
        let modelHeightContraint = NSLayoutConstraint(item: toView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: modelHeight)

        constraints = [centerY, centerX, modelWidthContraint, modelHeightContraint]
        containerView.addConstraints(constraints)

        let endFrame = toView.frame
        toView.frame = CGRect(x: endFrame.minX, y: containerView.frame.height, width: endFrame.width, height: endFrame.height)
        containerView.bringSubview(toFront: toView)

        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: UIViewAnimationOptions(rawValue: 0), animations: {
            self.coverView.alpha = 0.6
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
