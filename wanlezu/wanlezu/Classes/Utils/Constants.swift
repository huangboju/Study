//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

struct Constants {

    static let appName = Bundle.displayName
    static let appVersion = Bundle.releaseVersionNumber
    static let appVersionName = Bundle.releaseVersionName

    static let statusBarHeight: CGFloat = 20
    static let navgationBarHeight: CGFloat = 44
    static let tabBarHeight: CGFloat = 49
    static let topBarHeight = statusBarHeight + navgationBarHeight
    static let padding: CGFloat = IS_PLUS ? 20 : 15 // 60px 30px 究竟是15还是16
    static let offsetH: CGFloat = 10
    static let offsetV: CGFloat = 10
    static let padding_inner = padding
    static let padding_2 = 2 * padding
    static let commonScreenW = SCREEN_WIDTH - padding_2

    static let rowHeight: CGFloat = 44
    static let bigRowHeight: CGFloat = 80

    // 参考微信
    static let sectionHeaderHeight: CGFloat = 15
    static let sectionFooterHeight: CGFloat = 20
    static let tablewViewBottomHeight: CGFloat = 27.5
    static let buttonHeight = rowHeight

    static let CGSizeNavigationBarIcon = CGSize(width: 22, height: 22)
    static let CGSizeToolbarIcon = CGSize(width: 22, height: 22)
    static let CGSizeTabBarIcon = CGSize(width: 25, height: 25)
    static let CGSizeSettingsIcon = CGSize(width: 29, height: 29)

    // http://nshipster.cn/nsurl/

    // https://developer.apple.com/library/mac/documentation/Cocoa/Reference/Foundation/Classes/NSURL_Class/index.html
    static let apiScheme = "http"
    static let apiHostHeader = "plus"
    static let apiHost = apiHostHeader + ".cmcaifu.com"
    static let apiPath = "/api/v1/tv"
}

let NotificationManager = NotificationCenter.default
let ApplicationManager = UIApplication.shared
