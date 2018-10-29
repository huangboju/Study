//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class SwipeUpInteractiveTransition: UIPercentDrivenInteractiveTransition {
    var isInteracting = false

    private var isShouldComplete = false
    private var presentingVC: UIViewController?

    override var completionSpeed: CGFloat {
        set {}
        get {
            return 1 - percentComplete
        }
    }

    func wireTo(viewController: UIViewController) {
        presentingVC = viewController
        prepareGestureRecognizerIn(view: viewController.view)
    }

    func prepareGestureRecognizerIn(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handle))
        view.addGestureRecognizer(pan)
    }

    func handle(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: gesture.view?.superview)
        switch gesture.state {
        case .began:
            isInteracting = true
            presentingVC?.dismiss(animated: true, completion: nil)
        case .changed:
            var fraction = translation.y / 400
            fraction = CGFloat(fminf(fmaxf(Float(fraction), 0), 1))
            isShouldComplete = fraction > 0.5
            update(fraction)
        case .ended, .cancelled:
            isInteracting = false
            let condition = !isShouldComplete || gesture.state == .cancelled
            condition ? cancel() : finish()
        default:
            break
        }
    }
}
