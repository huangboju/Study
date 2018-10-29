//
//  SliderAnimationController.swift
//  ADController
//
//  Created by 伯驹 黄 on 2016/10/19.
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class SliderAnimationController: AnimatedTransitioning {
    
    private var translationH: CGFloat = 0
    private var translationW: CGFloat = 0
    private var isBeingPresented = false

    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }

        let containerView = transitionContext.containerView
        
        guard let fromView = fromVC.view else { return }
        guard let toView = toVC.view else { return }
        
        translationH = containerView.frame.height
        translationW = containerView.frame.width
        
        isBeingPresented = toVC.isBeingPresented
        if isBeingPresented {
            containerView.addSubview(toView)
        }

        toView.transform = transform(forKey: .to)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromView.transform = self.transform(forKey: .from)
            toView.transform = .identity
        }, completion: { _ in
            fromView.transform = .identity
            toView.transform = .identity
            let isCancelled = transitionContext.transitionWasCancelled
            transitionContext.completeTransition(!isCancelled)
        })
    }

    func transform(forKey transitionContext: UITransitionContextViewControllerKey) -> CGAffineTransform {
        let y: CGFloat
        let realTranslationH = -translationH
        if transitionContext == .from {
            y = isBeingPresented ? 0 : realTranslationH
        } else {
            y = isBeingPresented ? realTranslationH : 0
        }
        return CGAffineTransform(translationX: 0, y: y)
    }
}

