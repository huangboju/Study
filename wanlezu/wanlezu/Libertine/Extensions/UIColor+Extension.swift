//
//  Copyright © 2014年 NY. All rights reserved.
//

extension UIColor {

    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }

    /** 16进制颜色 */
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0xFF00) >> 8) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }

    public static var random: UIColor {
        let hue = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
        let saturation = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
        let brightness = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black

        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

    /**
     *  获取当前UIColor对象里的透明色值
     *
     *  @return 透明通道的色值，值范围为0.0-1.0
     */
    public var qmui_alpha: CGFloat {
        var a: CGFloat = 0
        if getRed(nil, green: nil, blue: nil, alpha: &a) {
            return a
        }
        return 0
    }

    // 命名为 systemBlueColor() systemRedColor() 会覆盖系统隐藏方法, 利用该特性可以方便的替换系统颜色
    public class var systemDefault: UIColor {
        return iOSBlue
    }

    public class var systemDestructive: UIColor {
        return iOSRed
    }

    // https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/ColorImagesText.html#//apple_ref/doc/uid/TP40006556-CH58-SW1
    public class var iOSLightBlue: UIColor {
        return UIColor(hex: 0x5AC8FA)
    }

    public class var iOSYellow: UIColor {
        return UIColor(hex: 0xFFCC00)
    }

    public class var iOSOrange: UIColor {
        return UIColor(hex: 0xFF9500)
    }

    public class var iOSDarkRed: UIColor {
        return UIColor(hex: 0xFF2D55)
    }

    public class var iOSBlue: UIColor {
        return UIColor(hex: 0x007AFF)
    }

    public class var iOSGreen: UIColor {
        return UIColor(hex: 0x4CD964)
    }

    public class var iOSRed: UIColor {
        return UIColor(hex: 0xFF3B30)
    }

    public class var iOSGray: UIColor {
        return UIColor(hex: 0x8E8E93)
    }

    public class var videosBlue: UIColor {
        return UIColor(hex: 0x5AC8FA)
    }

    public class var notesYellow: UIColor {
        return UIColor(hex: 0xFFCC00)
    }

    public class var iBooksOrange: UIColor {
        return UIColor(hex: 0xFF9500)
    }

    public class var newsPink: UIColor {
        return UIColor(hex: 0xFF2D55)
    }

    public class var safariBlue: UIColor {
        return UIColor(hex: 0x007AFF)
    }

    public class var messagesGreen: UIColor {
        return UIColor(hex: 0x4CD964)
    }

    public class var calendarRed: UIColor {
        return UIColor(hex: 0xFF3B30)
    }

    public class var settingsGray: UIColor {
        return UIColor(hex: 0x8E8E93)
    }

    public class var backgroundGray: UIColor {
        return UIColor(hex: 0xEFEFF4)
    }

    public class var linesGray: UIColor {
        return UIColor(hex: 0xCECED2)
    }

    public class var textBlack: UIColor {
        return UIColor(hex: 0x000000)
    }

    public class var linksBlue: UIColor {
        return UIColor(hex: 0x007AFF)
    }
}
