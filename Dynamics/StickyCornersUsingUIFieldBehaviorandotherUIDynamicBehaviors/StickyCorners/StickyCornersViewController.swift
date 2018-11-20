/*
    Copyright (C) 2015 Apple Inc. All Rights Reserved.
    See LICENSE.txt for this sample’s licensing information
    
    Abstract:
    StickyCornersViewController is a UIViewController subclass demonstrating the use of UIFieldBehavior.
*/

import UIKit

class StickyCornersViewController: UIViewController {
    // MARK: Properties
    
    // Dynamics.

    var animator: UIDynamicAnimator!

    var stickyBehavior: StickyCornersBehavior!
    
    var itemView: UIView!
    
    // Touch handling.

    var offset = CGPoint.zero

    let itemAspectRatio: CGFloat = 0.70
    
    // MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Determine a reasonable item size.
        let screenBounds = UIScreen.main.bounds
        let length = floor(0.1  * max(screenBounds.width, screenBounds.height))
        
        /*
            Create the itemView, add a pan gesture recognizer, then add the `itemView`
            as a subview of the viewController's view.
        */
        itemView = UIView(frame: CGRect(x: 0, y: 0, width: length, height: floor(length / itemAspectRatio)))
        itemView.autoresizingMask = []

        itemView.backgroundColor = UIColor.red
        
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan))
        itemView.addGestureRecognizer(panGestureRecognizer)
        
        view.addSubview(itemView)

        // Add a long press recognizer to toggle debugMode.
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        view.addGestureRecognizer(longPressGestureRecognizer)
        
        // Create a UIDynamicAnimator.
        animator = UIDynamicAnimator(referenceView: view)
        
        /*
            Create a StickyCornersBehavior with the itemView and a corner inset, 
            then add it to the animator.
        */
        stickyBehavior = StickyCornersBehavior(item: itemView, cornerInset: length * 0.5)
        animator.addBehavior(stickyBehavior)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
     
        // Ensure the item stays on screen during a bounds change.
        guard let corner = stickyBehavior.currentCorner else { return }

        stickyBehavior.isEnabled = false
        
        let bounds = CGRect(origin: CGPoint.zero, size: size)

        stickyBehavior.updateFields(in: bounds)

        coordinator.animate(alongsideTransition: { (context) in
            self.itemView.center = self.stickyBehavior.position(for: corner)
        }, completion: { context in
            self.stickyBehavior.isEnabled = true
        })
    }
    
    // MARK: Gesture Callbacks
    
    func pan(pan: UIPanGestureRecognizer) {
        var location = pan.location(in: view)
        
        switch pan.state {
            case .began:
                // Capture the initial touch offset from the itemView's center.
                let center = itemView.center
                offset.x = location.x - center.x
                offset.y = location.y - center.y
                
                // Disable the behavior while the item is manipulated by the pan recognizer.
                stickyBehavior.isEnabled = false
            
            case .changed:
                // Get reference bounds.
                let referenceBounds = view.bounds
                let referenceWidth = referenceBounds.width
                let referenceHeight = referenceBounds.height
                
                // Get item bounds.
                let itemBounds = itemView.bounds
                let itemHalfWidth = itemBounds.width / 2.0
                let itemHalfHeight = itemBounds.height / 2.0
                
                // Apply the initial offset.
                location.x -= offset.x
                location.y -= offset.y
                
                // Bound the item position inside the reference view.
                location.x = max(itemHalfWidth, location.x)
                location.x = min(referenceWidth - itemHalfWidth, location.x)
                location.y = max(itemHalfHeight, location.y)
                location.y = min(referenceHeight - itemHalfHeight, location.y)

                // Apply the resulting item center.
                itemView.center = location
            
            case .cancelled, .ended:
                // Get the current velocity of the item from the pan gesture recognizer.
                let velocity = pan.velocity(in: view)
                
                // Re-enable the stickyCornersBehavior.
                stickyBehavior.isEnabled = true
                
                // Add the current velocity to the sticky corners behavior.
                stickyBehavior.addLinearVelocity(velocity: velocity)
           
            default: ()
        }
    }
    
    func longPress(longPress: UILongPressGestureRecognizer) {
        guard longPress.state == .began else { return }

        // Toggle debug mode.
        animator.isDebugEnabled = !animator.isDebugEnabled
    }
}
