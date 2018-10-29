//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

public class ADController: UIViewController {

    public var contentSize = CGSize() {
        willSet {
            ADConfig.shared.ADViewSize = newValue
        }
    }

    public var showTimeInterval = ShowTimeInterval.day
    public var selectedHandel: ((Int, UIViewController) -> Void)?
    public var closedHandel: (() -> Void)?

    public var isShowPageControl = false
    public var isAllowLooping = false
    public var closeButtonImage: UIImage? {
        willSet {
            ADConfig.shared.closeButtonImage = newValue
        }
    }

    public var images = [UIImage]() {
        willSet {
            ADConfig.shared.firstImage = newValue[0]
        }
    }

    private var bundleImage: UIImage? {
        var bundle = Bundle(for: classForCoder)
        if let resourcePath = bundle.path(forResource: "ADController", ofType: "bundle"),
           let resourcesBundle = Bundle(path: resourcePath) {
            bundle = resourcesBundle
        }
        return UIImage(named: "ic_btn_close", in: bundle, compatibleWith: nil)
    }

    private lazy var presentTransitionDelegate = SDEModalTransitionDelegate()

    private var showedDate: String {
        return "\(classForCoder)showed_date"
    }

    private var adDateKey: String {
        return "\(classForCoder)AD_date"
    }
    
    
    convenience init(str: String) {
        self.init()
        transitioningDelegate = presentTransitionDelegate
        modalPresentationStyle = .custom
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        let contentView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width - 56, height: 416))
        contentView.backgroundColor = .red
        view.addSubview(contentView)

        if closeButtonImage == nil {
            ADConfig.shared.closeButtonImage = bundleImage
        }
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Constants.setShowed(Date())
    }

    public func isCanShowing(date: Date) -> Bool {
        guard let adDate = Constants.adDate else {
            Constants.set(date)
            return true
        }
        if date != adDate {
            Constants.set(date)
            return true
        }
        let oldDate = Constants.oldDate
        return -oldDate.timeIntervalSinceNow >= showTimeInterval.rawValue
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("⚠️⚠️⚠️\(classForCoder)")
    }
}

public enum ShowTimeInterval: TimeInterval {
    case hour = 3600
    case halfDay = 43200
    case day = 86400
}

struct Constants {
    static let adDateKey = "ADController_ad_date"
    static let showedDateKey = "ADController_showed_date"
    static let screenWidth = UIScreen.main.bounds.width
    static let screenHeight = UIScreen.main.bounds.height

    static var oldDate: Date {
        return (UserDefaults.standard.value(forKey: showedDateKey) as? Date) ?? Date()
    }

    static var adDate: Date? {
        return UserDefaults.standard.value(forKey: adDateKey) as? Date
    }

    static func set(_ date: Date) {
        UserDefaults.standard.set(date, forKey: adDateKey)
    }

    static func setShowed(_ date: Date) {
        UserDefaults.standard.set(date, forKey: showedDateKey)
    }
}

class ADConfig {
    var ADViewSize = CGSize(width: Constants.screenWidth * 0.618, height: Constants.screenHeight * 0.618)

    var closeButtonImage: UIImage?
    var firstImage = UIImage()
    var lastImage: UIImage?
    var isVertical = true
    var isOverlay = true
    static let shared = ADConfig()
    private init() {}
}
