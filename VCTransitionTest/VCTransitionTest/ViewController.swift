//
//  ViewController.swift
//  VCTransitionTest
//
//  Created by 伯驹 黄 on 2016/10/28.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var presentAnimation: BouncePresentAnimation?
    var dismissAnimation: NormalDismissAnimation?
    let transitionController = SwipeUpInteractiveTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 80.0, y: 210.0, width: 160.0, height: 40.0)
        button.setTitle("Click me", for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        view.addSubview(button)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

    }

    func buttonClicked() {
        let mvc = SecondController()
        mvc.transitioningDelegate = self
        transitionController.wireTo(viewController: mvc)
        present(mvc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented _: UIViewController, presenting _: UIViewController, source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return BouncePresentAnimation()
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return NormalDismissAnimation()
    }

    func interactionControllerForDismissal(using _: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return transitionController.isInteracting ? transitionController : nil
    }
}
