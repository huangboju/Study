//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import AVFoundation

extension UIViewController {

    var isFirstOpen: Bool {
        return !APPDefaults[.isFirstOpen]
    }

    func setTabBarVisible(_ visible: Bool, animated: Bool) {

        // * This cannot be called before viewDidLayoutSubviews(), because the frame is not set before this time

        // bail if the current state matches the desired state
        if tabBarIsVisible == visible { return }

        // get a frame calculation ready
        let frame = tabBarController?.tabBar.frame
        let height = frame?.size.height
        let offsetY = (visible ? -height! : height)

        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)

        //  animate the tabBar
        if let rect = frame {
            UIView.animate(withDuration: duration) {
                self.tabBarController?.tabBar.frame = rect.offsetBy(dx: 0, dy: offsetY!)
            }
        }
    }

    var tabBarIsVisible: Bool {
        return (tabBarController?.tabBar.frame.minY)! < view.frame.maxY
    }

    public func transion(to vc: UIViewController, animated: Bool = true) {
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: animated)
    }
}
