//
//  QMUICommonDefines.swift
//  QMUI.swift
//
//  Created by 伯驹 黄 on 2017/1/17.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

// MARK: - 变量-编译相关

// 判断当前是否debug编译模式
#if DEBUG
    let IS_DEBUG = true
#else
    let IS_DEBUG = false
#endif

// MARK: - Clang
// TODO:

// 设备类型
let IS_IPAD = AppHelper.isIPad
let IS_IPAD_PRO = AppHelper.isIPadPro
let IS_IPOD = AppHelper.isIPod
let IS_IPHONE = AppHelper.isIPhone
let IS_SIMULATOR = AppHelper.isSimulator
let IS_PLUS = SCREEN_WIDTH == 414

// 操作系统版本号
let IOS_VERSION = Double(UIDevice.current.systemVersion) ?? 0

// 是否横竖屏
// 用户界面横屏了才会返回true
let IS_LANDSCAPE = UIInterfaceOrientationIsLandscape(UIApplication.shared.statusBarOrientation)
// 无论支不支持横屏，只要设备横屏了，就会返回YES
let IS_DEVICE_LANDSCAPE = UIDeviceOrientationIsLandscape(UIDevice.current.orientation)

// 左边间距
let PADDING: CGFloat = IS_PLUS ? 20 : 15
let PADDING_2: CGFloat = 2 * PADDING

// 屏幕宽度，会根据横竖屏的变化而变化
let SCREEN_WIDTH = UIScreen.main.bounds.width

let BODY_WIDTH = SCREEN_WIDTH - PADDING_2
let CELL_HEIGHT: CGFloat = 44

// 屏幕高度，会根据横竖屏的变化而变化
let SCREEN_HEIGHT = UIScreen.main.bounds.height

// 屏幕宽度，跟横竖屏无关
let DEVICE_WIDTH = IS_LANDSCAPE ? UIScreen.main.bounds.height : UIScreen.main.bounds.width

// 屏幕高度，跟横竖屏无关
let DEVICE_HEIGHT = IS_LANDSCAPE ? UIScreen.main.bounds.width : UIScreen.main.bounds.height

// 设备屏幕尺寸
let IS_55INCH_SCREEN = AppHelper.is55InchScreen
let IS_47INCH_SCREEN = AppHelper.is47InchScreen
let IS_40INCH_SCREEN = AppHelper.is40InchScreen
let IS_35INCH_SCREEN = AppHelper.is35InchScreen

// 是否Retina
let IS_RETINASCREEN = UIScreen.main.scale >= 2.0

// 是否支持动态字体
let IS_RESPOND_DYNAMICTYPE = UIApplication.instancesRespond(to: #selector(getter: UIApplication.preferredContentSizeCategory))

// MARK: - 变量-布局相关

// bounds && nativeBounds / scale && nativeScale
let ScreenBoundsSize = UIScreen.main.bounds.size
let ScreenNativeBoundsSize = IOS_VERSION >= 8.0 ? UIScreen.main.nativeBounds.size : ScreenBoundsSize
let ScreenScale = UIScreen.main.scale
let ScreenNativeScale = IOS_VERSION >= 8.0 ? UIScreen.main.nativeScale : ScreenScale
// 区分设备是否处于放大模式（iPhone 6及以上的设备支持放大模式）
let ScreenInDisplayZoomMode = ScreenNativeScale > ScreenScale

// 状态栏高度(来电等情况下，状态栏高度会发生变化，所以应该实时计算)
let StatusBarHeight = UIApplication.shared.statusBarFrame.height

// navigationBar相关frame
let NavigationBarHeight: CGFloat = IS_LANDSCAPE ? PreferredVarForDevices(44, 32, 32, 32) : 44

let TopBarHeight = StatusBarHeight + NavigationBarHeight

// toolBar的相关frame
let ToolBarHeight: CGFloat = (IS_LANDSCAPE ? PreferredVarForDevices(44, 32, 32, 32) : 44)

let TabBarHeight: CGFloat = 49

// 除去navigationBar和toolbar后的中间内容区域
func NavigationContentHeight(_ viewController: UIViewController) -> CGFloat {
    guard let nav = viewController.navigationController else {
        return viewController.view.frame.height - NavigationBarHeight - StatusBarHeight
    }
    let height = nav.isToolbarHidden ? 0 : nav.toolbar.frame.height
    return viewController.view.frame.height - NavigationBarHeight - StatusBarHeight - height
}

// 兼容controller.view的subView的top值在不同iOS版本下的差异
let NavigationContentTop = StatusBarHeight + NavigationBarHeight // 这是动态获取的
let NavigationContentStaticTop = 20 + NavigationBarHeight // 不动态从状态栏获取高度，避免来电模式下多算了20pt（来电模式下系统会把UIViewController.view的frame往下移动20pt）
func NavigationContentOriginY(_ y: CGFloat) -> CGFloat {
    return NavigationContentTop + y
}

let PixelOne = AppHelper.pixelOne

// 获取最合适的适配值，默认以varFor55Inch为准，也即偏向大屏
func PreferredVarForDevices<T>(_ varFor55Inch: T, _ varFor47Inch: T, _ varFor40Inch: T, _ var4: T) -> T {
    return (IS_35INCH_SCREEN ? var4 : (IS_40INCH_SCREEN ? varFor40Inch : (IS_47INCH_SCREEN ? varFor47Inch : varFor55Inch)))
}

// 同上，加多一个iPad的参数
func PreferredVarForUniversalDevices<T>(varForPad: T, varFor55Inch: T, varFor47Inch: T, varFor40Inch: T, var4: T) -> T {
    return (IS_IPAD ? varForPad : (IS_55INCH_SCREEN ? varFor55Inch : (IS_47INCH_SCREEN ? varFor47Inch : (IS_40INCH_SCREEN ? varFor40Inch : var4))))
}

// 字体相关创建器，包括动态字体的支持
let UIFontMake: (CGFloat) -> UIFont = { UIFont.systemFont(ofSize: $0) }
// 斜体只对数字和字母有效，中文无效
let UIFontItalicMake: (CGFloat) -> UIFont = { UIFont.italicSystemFont(ofSize: $0) }
let UIFontBoldMake: (CGFloat) -> UIFont = { UIFont.boldSystemFont(ofSize: $0) }
let UIFontBoldWithFont: (UIFont) -> UIFont = { UIFont.boldSystemFont(ofSize: $0.pointSize) }
let UIFontLightMake: (CGFloat) -> UIFont = { UIFont.qmui_lightSystemFont(ofSize: $0) }
let UIFontLightWithFont: (UIFont) -> UIFont = { UIFont.qmui_lightSystemFont(ofSize: $0.pointSize) }
let UIDynamicFontMake: (CGFloat) -> UIFont = { UIFont.qmui_dynamicFont(withSize: $0, bold: false) }
let UIDynamicFontMakeWithLimit: (CGFloat, CGFloat, CGFloat) -> UIFont = { UIFont.qmui_dynamicFont(withSize: $0.0, upperLimitSize: $0.1, lowerLimitSize: $0.2, bold: false) }
let UIDynamicFontBoldMake: (CGFloat) -> UIFont = { UIFont.qmui_dynamicFont(withSize: $0, bold: true) }
let UIDynamicFontBoldMakeWithLimit: (CGFloat, CGFloat, CGFloat) -> UIFont = { UIFont.qmui_dynamicFont(withSize: $0.0, upperLimitSize: $0.1, lowerLimitSize: $0.2, bold: true) }

// MARK: - 数学计算

let AngleWithDegrees: (CGFloat) -> CGFloat = { .pi * $0 / 180.0 }

// MARK: - 动画
// TODO:
// let QMUIViewAnimationOptionsCurveOut (7<<16)
// let QMUIViewAnimationOptionsCurveIn (8<<16)

// MARK: - 其他
// TODO:
// #define QMUILog(...) [[AppHelper sharedInstance] printLogWithCalledFunction:__FUNCTION__ log:__VA_ARGS__]

/**
 *  基于指定的倍数，对传进来的 floatValue 进行像素取整。若指定倍数为0，则表示以当前设备的屏幕倍数为准。
 *
 *  例如传进来 “2.1”，在 2x 倍数下会返回 2.5（0.5pt 对应 1px），在 3x 倍数下会返回 2.333（0.333pt 对应 1px）。
 */

func flatSpecificScale(_ value: CGFloat, _ scale: CGFloat) -> CGFloat {
    let s = scale == 0 ? ScreenScale : scale
    return ceil(value * s) / s
}

/**
 *  基于当前设备的屏幕倍数，对传进来的 floatValue 进行像素取整。
 *
 *  注意如果在 Core Graphic 绘图里使用时，要注意当前画布的倍数是否和设备屏幕倍数一致，若不一致，不可使用 flat() 函数，而应该用 flatSpecificScale
 */

func flat(_ value: CGFloat) -> CGFloat {
    return flatSpecificScale(value, 0)
}

/**
 *  类似flat()，只不过 flat 是向上取整，而 floorInPixel 是向下取整
 */
func floorInPixel(_ value: CGFloat) -> CGFloat {
    let resultValue = floor(value * ScreenScale) / ScreenScale
    return resultValue
}

func between(_ minimumValue: CGFloat, _ value: CGFloat, _ maximumValue: CGFloat) -> Bool {
    return minimumValue < value && value < maximumValue
}

func betweenOrEqual(_ minimumValue: CGFloat, _ value: CGFloat, _ maximumValue: CGFloat) -> Bool {
    return minimumValue <= value && value <= maximumValue
}

func ReplaceMethod(_ _class: AnyClass, _ _originSelector: Selector, _ _newSelector: Selector) {
    let oriMethod = class_getInstanceMethod(_class, _originSelector)
    let newMethod = class_getInstanceMethod(_class, _newSelector)
    let isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod))
    if isAddedMethod {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod))
    } else {
        method_exchangeImplementations(oriMethod, newMethod)
    }
}

// MARK: - CGFloat

/// 用于居中运算

func CGFloatGetCenter(_ parent: CGFloat, _ child: CGFloat) -> CGFloat {
    return flat((parent - child) / 2.0)
}

// MARK: - CGPoint

/// 两个point相加

extension CGPoint {
    func union(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: flat(x + point.x), y: flat(y + point.y))
    }
}

/// 创建一个像素对齐的CGRect
let CGRectFlat: (CGFloat, CGFloat, CGFloat, CGFloat) -> CGRect = {
    CGRect(x: flat($0.0), y: flat($0.1), width: flat($0.2), height: flat($0.3))
}
