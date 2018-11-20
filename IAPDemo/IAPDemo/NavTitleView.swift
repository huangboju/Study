//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class NavTitleView: UIView {
    var textLabel: UILabel?
    var indicatorView: UIActivityIndicatorView?

    override init(frame: CGRect) {
        super.init(frame: frame)
        indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        addSubview(indicatorView!)
        textLabel = UILabel()
        textLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        addSubview(textLabel!)
    }

    func setText(str: String) {
        indicatorView?.startAnimating()
        textLabel?.text = str + "..."
        textLabel?.sizeToFit()
        textLabel?.frame.origin.x = indicatorView!.frame.maxX + Constans.offsetH
        frame.size = CGSize(width: Constans.offsetH + indicatorView!.frame.width + textLabel!.frame.width, height: max(indicatorView!.frame.height, textLabel!.frame.height))
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct Constans {
    static let screenW = UIScreen.main.bounds.width
    static let screenH = UIScreen.main.bounds.height
    static let offsetH: CGFloat = 10
    static let offsetV: CGFloat = 10
}

extension UINavigationItem {
    func showTitleView(with text: String) {
        let titleView = NavTitleView()
        titleView.setText(str: text)
        self.titleView = titleView
    }

    func hideTitleView() {
        titleView = nil
    }
}

extension UIResponder {

    struct Keys {
        static let button = "button"
    }

    struct EventName {
        static let transferNameEvent = "transferNameEvent"
    }

    func router(with eventName: String, userInfo: [String: Any]) {
        if let next = next {
            next.router(with: eventName, userInfo: userInfo)
        }
    }
}
