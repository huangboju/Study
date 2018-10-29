//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

extension UIViewController {

    @discardableResult
    func showAlert(title: String? = nil, message: String?, style: UIAlertControllerStyle = .alert, handle: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        present(alert, animated: true, completion: nil)
        return alert.action("确定", handle)
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

    public func transion(to dest: Dest, animated: Bool = true) {
        let vc: UIViewController
        switch dest {
        case let .controller(c):
            vc = c
        case let .dest(c):
            vc = c.init()
        case .web:
//            vc = WebController(url: url)
            vc = UIViewController()
            break
        case let .scheme(s):
            guard let url = URL(string: s.scheme) else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
            return
        default:
            return
        }
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: animated)
    }
}

public enum Dest {
    case none
    // 用于SegueRow，把创建对象延迟到跳转时
    case dest(UIViewController.Type)
    case controller(UIViewController)
    case web(String)
    case scheme(Scheme)
}

// https://github.com/cyanzhong/app-tutorials/blob/master/schemes.md
// http://www.jianshu.com/p/bb3f42fdbc31
public enum Scheme {
    case plain(String)
    case tel(String)
    case wifi
    case appStore
    case mail(String)
    case notification

    var scheme: String {
        let scheme: String
        switch self {
        case let .plain(s):
            scheme = s
        case let .tel(s):
            scheme = "tel://" + s
        case .wifi:
            scheme = "App-Prefs:root=WIFI"
        case .appStore:
            scheme = ""
//            scheme = "itms-apps://itunes.apple.com/cn/app/id\(Constants.appid)?mt=8"
        case let .mail(s):
            scheme = "mailto://\(s)"
        case .notification:
            scheme = "App-Prefs:root=NOTIFICATIONS_ID"
        }
        return scheme
    }
}
