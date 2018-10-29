//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class NormalDismissAnimation: AnimatedTransitioning {

    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView

        // 2. Set init frame for fromVC
        let screenBounds = UIScreen.main.bounds
        let initFrame = transitionContext.initialFrame(for: fromVC)
        let finalFrame = initFrame.offsetBy(dx: 0, dy: screenBounds.height)

        containerView.addSubview(toVC.view)
        containerView.sendSubview(toBack: toVC.view)

        // 4. Do animate now
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromVC.view.frame = finalFrame
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
