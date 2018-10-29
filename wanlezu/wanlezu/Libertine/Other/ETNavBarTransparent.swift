//
//  ETNavBarTransparent.swift
//  ETNavBarTransparentDemo
//
//  Created by Bing on 2017/3/1.
//  Copyright © 2017年 tanyunbing. All rights reserved.
//

extension UIColor {
    // System default bar tint color
    open class var defaultNavBarTintColor: UIColor {
        return UIColor(red: 0, green: 0.478431, blue: 1, alpha: 1.0)
    }
}

extension UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }

    open override var preferredStatusBarStyle: UIStatusBarStyle {
        return topViewController?.preferredStatusBarStyle ?? .default
    }

    private static let _onceToken = UUID().uuidString

    open override class func initialize() {

        if self == UINavigationController.self {

            DispatchQueue.once(token: _onceToken) {
                let needSwizzleSelectorArr = [
                    NSSelectorFromString("_updateInteractiveTransition:"),
                    #selector(popToViewController),
                    #selector(popToRootViewController),
                ]

                for selector in needSwizzleSelectorArr {

                    let str = ("et_" + selector.description).replacingOccurrences(of: "__", with: "_")
                    /*
                     popToRootViewControllerAnimated: et_popToRootViewControllerAnimated:*/

                    ReplaceMethod(self, selector, Selector(str))
                }
            }
        }
    }

    func et_updateInteractiveTransition(_ percentComplete: CGFloat) {

        guard let topVC = topViewController, let coor = topVC.transitionCoordinator else {
            et_updateInteractiveTransition(percentComplete)
            return
        }

        let fromVC = coor.viewController(forKey: .from)
        let toVC = coor.viewController(forKey: .to)

        // Bg Alpha
        let fromAlpha = fromVC?.navBarBgAlpha ?? 0
        let toAlpha = toVC?.navBarBgAlpha ?? 0
        let nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percentComplete

        setNeedsNavigationBackground(nowAlpha)

        //tintColor
        let fromColor = fromVC?.navBarTintColor ?? .blue
        let toColor = toVC?.navBarTintColor ?? .blue
        let nowColor = averageColor(fromColor: fromColor, toColor: toColor, percent: percentComplete)
        navigationBar.tintColor = nowColor
        et_updateInteractiveTransition(percentComplete)
    }

    // Calculate the middle Color with translation percent
    private func averageColor(fromColor: UIColor, toColor: UIColor, percent: CGFloat) -> UIColor {
        var fromRed: CGFloat = 0.0
        var fromGreen: CGFloat = 0.0
        var fromBlue: CGFloat = 0.0
        var fromAlpha: CGFloat = 0.0
        fromColor.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)

        var toRed: CGFloat = 0.0
        var toGreen: CGFloat = 0.0
        var toBlue: CGFloat = 0.0
        var toAlpha: CGFloat = 0.0
        toColor.getRed(&toRed, green: &toGreen, blue: &toBlue, alpha: &toAlpha)

        let nowRed = fromRed + (toRed - fromRed) * percent
        let nowGreen = fromGreen + (toGreen - fromGreen) * percent
        let nowBlue = fromBlue + (toBlue - fromBlue) * percent
        let nowAlpha = fromAlpha + (toAlpha - fromAlpha) * percent

        return UIColor(red: nowRed, green: nowGreen, blue: nowBlue, alpha: nowAlpha)
    }

    func et_popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBackground(viewController.navBarBgAlpha)
        navigationBar.tintColor = viewController.navBarTintColor
        return et_popToViewController(viewController, animated: animated)
    }

    func et_popToRootViewControllerAnimated(_ animated: Bool) -> [UIViewController]? {
        setNeedsNavigationBackground(viewControllers.first?.navBarBgAlpha ?? 0)
        navigationBar.tintColor = viewControllers.first?.navBarTintColor
        return et_popToRootViewControllerAnimated(animated)
    }

    fileprivate func setNeedsNavigationBackground(_ alpha: CGFloat) {

        let barBackgroundView = navigationBar.subviews[0]

        let valueForKey = barBackgroundView.value(forKey:)

        if let shadowView = valueForKey("_shadowView") as? UIView {
            shadowView.alpha = alpha
        }

        if navigationBar.isTranslucent {
            if #available(iOS 10.0, *) {
                if let backgroundEffectView = valueForKey("_backgroundEffectView") as? UIView, navigationBar.backgroundImage(for: .default) == nil {
                    backgroundEffectView.alpha = alpha
                    return
                }

            } else {
                if let adaptiveBackdrop = valueForKey("_adaptiveBackdrop") as? UIView, let backdropEffectView = adaptiveBackdrop.value(forKey: "_backdropEffectView") as? UIView {
                    backdropEffectView.alpha = alpha
                    return
                }
            }
        }

        barBackgroundView.alpha = alpha
    }
}

extension UINavigationController: UINavigationControllerDelegate, UINavigationBarDelegate {

    public func navigationController(_ navigationController: UINavigationController, willShow _: UIViewController, animated _: Bool) {
        guard let topVC = navigationController.topViewController, let coor = topVC.transitionCoordinator else {
            return
        }

        if #available(iOS 10.0, *) {
            coor.notifyWhenInteractionChanges({ context in
                self.dealInteractionChanges(context)
            })
        } else {
            coor.notifyWhenInteractionEnds({ context in
                self.dealInteractionChanges(context)
            })
        }
    }

    private func dealInteractionChanges(_ context: UIViewControllerTransitionCoordinatorContext) {
        let animations: (UITransitionContextViewControllerKey) -> Void = {
            let nowAlpha = context.viewController(forKey: $0)?.navBarBgAlpha ?? 0
            self.setNeedsNavigationBackground(nowAlpha)

            self.navigationBar.tintColor = context.viewController(forKey: $0)?.navBarTintColor
        }

        if context.isCancelled {
            let cancellDuration: TimeInterval = context.transitionDuration * Double(context.percentComplete)
            UIView.animate(withDuration: cancellDuration, animations: {
                animations(.from)
            })
        } else {
            let finishDuration: TimeInterval = context.transitionDuration * Double(1 - context.percentComplete)
            UIView.animate(withDuration: finishDuration, animations: {
                animations(.to)
            })
        }
    }

    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop _: UINavigationItem) -> Bool {
        if let topVC = topViewController, let coor = topVC.transitionCoordinator, coor.initiallyInteractive {
            return true
        }

        let itemCount = navigationBar.items?.count ?? 0
        let n = viewControllers.count >= itemCount ? 2 : 1
        let popToVC = viewControllers[viewControllers.count - n]

        popToViewController(popToVC, animated: true)

        return true
    }

    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush _: UINavigationItem) -> Bool {
        setNeedsNavigationBackground(topViewController?.navBarBgAlpha ?? 0)
        navigationBar.tintColor = topViewController?.navBarTintColor
        return true
    }
}

extension UIViewController {

    fileprivate struct AssociatedKeys {
        static var navBarBgAlpha: CGFloat = 1.0
        static var navBarTintColor: UIColor = UIColor.defaultNavBarTintColor
    }

    private var isTranslucentBar: Bool {
        return navBarBgAlpha == 0
    }

    private static let _onceToken = UUID().uuidString

    open override class func initialize(){
        DispatchQueue.once(token: _onceToken) {
            let needSwizzleSelectorArr = [
                #selector(viewWillAppear)
            ]
            needSwizzleSelectorArr.forEach() {
                ReplaceMethod(self, $0, Selector(("et_" + $0.description)))
            }
        }
    }

    func fixTabbarCover(with scrollView: UIScrollView) {
        let bottom = tabBarController?.tabBar.frame.height ?? 0
        scrollView.contentInset.bottom = bottom
        scrollView.scrollIndicatorInsets.bottom = bottom
    }

    func et_viewWillAppear(_ animated: Bool) {
        let bar = navigationController?.navigationBar
        if isTranslucentBar {
            bar?.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.clear]
        } else {
            _ = bar?.titleTextAttributes?.removeValue(forKey: NSForegroundColorAttributeName)
        }
        et_viewWillAppear(animated)
    }

    public var navBarBgAlpha: CGFloat {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.navBarBgAlpha) as? CGFloat ?? 1
        }
        set {
            let alpha = max(min(newValue, 1), 0) // 必须在 0~1的范围

            if alpha == 0 {
                // 不设这个系统会调整tableView的contentOffset（contentOffset改变会调用scrollViewDidScroll)
                automaticallyAdjustsScrollViewInsets = false
            }

            objc_setAssociatedObject(self, &AssociatedKeys.navBarBgAlpha, alpha, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

            //Update UI
            navigationController?.setNeedsNavigationBackground(alpha)
        }
    }

    open var navBarTintColor: UIColor {
        get {
            guard let tintColor = objc_getAssociatedObject(self, &AssociatedKeys.navBarTintColor) as? UIColor else {
                return UIColor.defaultNavBarTintColor
            }
            return tintColor
        }
        set {
            navigationController?.navigationBar.tintColor = newValue
            objc_setAssociatedObject(self, &AssociatedKeys.navBarTintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
