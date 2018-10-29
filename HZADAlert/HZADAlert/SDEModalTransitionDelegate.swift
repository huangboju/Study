//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class SDEModalTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    var animatedTransitioning: UIViewControllerAnimatedTransitioning {
        return SliderAnimationController()
    }

    func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatedTransitioning
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatedTransitioning
    }

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source _: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
}
