//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class BouncePresentAnimation: AnimatedTransitioning {
    override func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1. Get controllers from transition context
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }

        // 2. Set init frame for toVC
        let screenBounds = UIScreen.main.bounds
        let finalFrame = transitionContext.finalFrame(for: toVC)
        toVC.view.frame = finalFrame.offsetBy(dx: 0, dy: screenBounds.height)

        // 3. Add toVC's view to containerView
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)

        // 4. Do animate now
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: .curveLinear, animations: {
            toVC.view.frame = finalFrame
        }) { _ in
            transitionContext.completeTransition(true)
        }
    }
}
