//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class PresentationController: UIPresentationController {
    private lazy var dimmingView: UIView = {
        let dimmingView = UIView()
        dimmingView.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        dimmingView.center = self.containerView?.center ?? .zero
        dimmingView.bounds = CGRect(origin: .zero, size: CGSize(width: 300, height: 420))
        return dimmingView
    }()

    override func presentationTransitionWillBegin() {
        containerView?.addSubview(dimmingView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {
            _ in
            self.dimmingView.bounds = self.containerView?.bounds ?? .zero
        }, completion: nil)
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        }, completion: nil)
        dismissAction()
    }

    func dismissAction() {
        var applyTransform = CGAffineTransform(rotationAngle: 3 * .pi)
        applyTransform = applyTransform.scaledBy(x: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.4, animations: {
        }, completion: { _ in
            self.presentedViewController.dismiss(animated: true, completion: nil)
        })
    }

    override func containerViewWillLayoutSubviews() {
        guard let containerView = containerView else {
            return
        }
        dimmingView.center = containerView.center
        dimmingView.bounds = containerView.bounds

        presentedView?.frame.origin.y = -80
        presentedView?.center.x = containerView.center.x
        // 显示部分的大小

        let size = CGSize(width: dimmingView.frame.width - 56, height: 416)
        presentedView?.bounds = CGRect(origin: .zero, size: size)
    }
}
