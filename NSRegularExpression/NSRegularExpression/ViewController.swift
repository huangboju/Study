//
//  ViewController.swift
//  NSRegularExpression
//
//  Created by 伯驹 黄 on 2017/3/3.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

// 谓词
// http://nshipster.com/nspredicate/

// 正则
// http://www.jianshu.com/p/ea10003d224a
// http://www.jianshu.com/p/d569dc998073
// http://www.jianshu.com/p/00da4d87b777

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let str1 = "欢迎访问http://www.hangge.com"
        print(str1)
        print(verifyUrl(str1))

        let str2 = "http://www.hangge.com"
        print(str2)
        print(verifyUrl(str2))

        print(getUrls())

        findPhoneNumberAndAdress()
        findWords()

        phoneNumber()

        test()
    }

    /*
     typedef NS_OPTIONS(NSUInteger, NSRegularExpressionOptions) {
     NSRegularExpressionCaseInsensitive             = 1 << 0, //不区分字母大小写的模式
     NSRegularExpressionAllowCommentsAndWhitespace  = 1 << 1, //忽略掉正则表达式中的空格和#号之后的字符
     NSRegularExpressionIgnoreMetacharacters        = 1 << 2, //将正则表达式整体作为字符串处理
     NSRegularExpressionDotMatchesLineSeparators    = 1 << 3, //允许.匹配任何字符，包括换行符
     NSRegularExpressionAnchorsMatchLines           = 1 << 4, //允许^和$符号匹配行的开头和结尾
     NSRegularExpressionUseUnixLineSeparators       = 1 << 5, //设置\n为唯一的行分隔符，否则所有的都有效。
     NSRegularExpressionUseUnicodeWordBoundaries    = 1 << 6 //使用Unicode TR#29标准作为词的边界，否则所有传统正则表达式的词边界都有效
     };
     */

    func test() {
        let str = "@jack12:【动物尖叫合辑】#肥猪流#猫头鹰这么尖叫[偷笑]、@船长: 老鼠这么尖叫、兔子这么尖叫[吃惊]、@花满楼: 莫名奇#小笼包#妙的笑到最后[好爱哦]！~ http://www.jianshu.com 电话: 17334332342"

        // 1.匹配@名字:
        //        let pattern = "@.*?:"

        // 2.匹配URL
        //        let pattern = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"

        // 3.匹配话题 #....#
        let pattern = "#.*?#"

        // 4.手机号码匹配
        //        let pattern = "1[3578]\\d{9}$"

        do {
            let regular = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let results = regular.matches(in: str, options: .reportProgress, range: NSRange(location: 0, length: str.characters.count))
            // 输出截取结果

            for result in results {
                print(str.substr(with: result.range))
            }
        } catch let error {
            print(error)
        }
    }

    func phoneNumber() {
        let nstring = "hahahha021-99999999"
        // 定义正则表达式

        //        let pattern = "^0\\d{2}-?\\d{8}$"
        let pattern = "(0[0-9]{2})-?\\d{8}$|^(0[0-9]{3}-?(\\d{7,8}))$"
        do {
            let regular = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let results = regular.matches(in: nstring, options: .reportProgress, range: NSRange(location: 0, length: nstring.characters.count))
            // 输出截取结果

            for result in results {
                print(nstring.substr(with: result.range))
            }
        } catch let error {
            print(error)
        }
    }

    func findWords() {
        let nstring = "美国,日本,澳大利亚,中国,俄罗斯,中国龙,阿萨德中国"
        // 定义正则表达式
        let pattern = "\\b中国\\b"
        do {
            let regular = try NSRegularExpression(pattern: pattern, options: .caseInsensitive)
            let results = regular.matches(in: nstring, options: .reportProgress, range: NSRange(location: 0, length: nstring.characters.count))
            // 输出截取结果

            for result in results {
                print(nstring.substr(with: result.range))
            }
        } catch let error {
            print(error)
        }
    }

    /*
     当初始化 NSDataDetector 的时候，确保只指定你感兴趣的类型。
     每当增加一个需要检查的类型，随着而来的是不小的性能损失为代价。
     */
    // http://nshipster.cn/nsdatadetector/
    func findPhoneNumberAndAdress() { // 中文地址好像不行
        let string = "123 Main St. / (555) 555-5555"
        let types: NSTextCheckingResult.CheckingType = [.address, .phoneNumber]

        do {
            let detector = try NSDataDetector(types:
                NSTextCheckingTypes(types.rawValue))

            let results = detector.matches(in: string, options: [], range: NSMakeRange(0, (string as NSString).length))
            print(#function)
            for result in results {
                print(string.substr(with: result.range))
            }
        } catch let error {
            print(error)
        }
    }

    // http://www.hangge.com/blog/cache/detail_1105.html
    /**
     验证URL格式是否正确
     */
    private func verifyUrl(_ str: String) -> Bool {
        // 创建一个正则表达式对象
        do {
            let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(NSTextCheckingResult.CheckingType.link.rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str, options: [], range: NSRange(location: 0, length: str.characters.count))
            // 判断结果(完全匹配)
            if res.count == 1 && res[0].range.location == 0
                && res[0].range.length == str.characters.count {
                return true
            }
        } catch {
            print(error)
        }
        return false
    }

    /**
     验证URL格式是否正确
     */
    private func verifyUrl2(_ str: String) -> Bool {
        // 创建NSURL实例
        if let url = URL(string: str) {
            // 检测应用是否能打开这个NSURL实例
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }

    /**
     匹配字符串中所有的URL
     */
    private func getUrls() -> [String] {
        let str = "欢迎访问http://www.hangge.com，https://hangge.com\n以及ftp://hangge.com"
        var urls = [String]()
        // 创建一个正则表达式对象
        do {
            let rawValue = NSTextCheckingResult.CheckingType.link.rawValue
            let dataDetector = try NSDataDetector(types:
                NSTextCheckingTypes(rawValue))
            // 匹配字符串，返回结果集
            let res = dataDetector.matches(in: str, options: [], range: NSMakeRange(0, str.characters.count))
            // 取出结果
            for checkingRes in res {
                urls.append((str as NSString).substring(with: checkingRes.range))
            }
        } catch {
            print(error)
        }
        return urls
    }
}

extension String {
    func substr(with range: NSRange) -> String {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(endIndex, offsetBy: range.location + range.length - characters.count)
        return substring(with: start ..< end)
    }
}
