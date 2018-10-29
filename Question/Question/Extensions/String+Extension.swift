//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

extension String {

    var encode: String {
        let unreservedChars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~"
        let unreservedCharset = CharacterSet(charactersIn: unreservedChars)

        return addingPercentEncoding(withAllowedCharacters: unreservedCharset) ?? self
    }

    var decode: String {
        return removingPercentEncoding ?? self
    }

    var length: Int {
        return characters.count
    }

    /// 多个单词用下划线隔开
    var local: String {
        let words = components(separatedBy: "_").map { $0.lowercased() }
        var localWords = [String]()
        words.forEach {
            let value = NSLocalizedString($0, comment: "")
            let localWord = $0 != value ? value : NSLocalizedString($0, tableName: "Default", comment: "")
            localWords.append(localWord)
        }
        return localWords.reduce("", +)
    }

    var toSnakecaseStr: String {
        var snake = ""
        for (i, char) in characters.enumerated() {
            if i == 0 {
                snake.append(char)
                continue
            }

            if "A" <= char && "Z" >= char {
                snake.append("_\(char)")
            } else {
                snake.append(char)
            }
        }
        return snake
    }

    var camelcaseString: String {
        if characters.contains(" ") {
            let first = substring(to: index(startIndex, offsetBy: 1))
            let cammel = capitalized.replacingOccurrences(of: " ", with: "")
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = lowercased().substring(to: index(startIndex, offsetBy: 1))
            let rest = String(characters.dropFirst())
            return "\(first)\(rest)"
        }
    }

    func fromClassName() -> UIViewController {
        let classNameStr = (Bundle.main.infoDictionary!["CFBundleName"] as? String) ?? ""
        let className = classNameStr + "." + self
        let aClass = NSClassFromString(className) as? UIViewController.Type
        return (aClass?.init()) ?? UIViewController()
    }

    func size(font: UIFont, width: CGFloat = SCREEN_WIDTH) -> CGSize {
        return (self as NSString).boundingRect(with: CGSize(width: width, height: CGFloat(HUGE)), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size
    }

    /// 是否包含某个字符串
    func has(_ s: String) -> Bool {
        return range(of: s) != nil
    }

    /// 分割字符
    func split(_ s: String) -> [String] {
        if s.isEmpty {
            return []
        }
        return components(separatedBy: s)
    }

    func range(of searchString: String) -> NSRange {
        return (self as NSString).range(of: searchString)
    }

    /// 去掉左右空格
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }

    func replace(_ old: String, new: String) -> String {
        return replacingOccurrences(of: old, with: new, options: NSString.CompareOptions.numeric, range: nil)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }

    func substring(to: Int) -> String {
        return substring(to: index(from: to))
    }

    func index(from: Int) -> Index {
        return index(startIndex, offsetBy: from)
    }

    func substring(fromIndex: Int, toIndex: Int) -> String {
        let range = NSRange(location: fromIndex, length: toIndex - fromIndex)
        return substr(with: range)
    }

    func substr(with range: NSRange) -> String {
        let start = index(startIndex, offsetBy: range.location)
        let end = index(endIndex, offsetBy: range.location + range.length - characters.count)
        return substring(with: start ..< end)
    }

    func size(of font: UIFont) -> CGSize {
        return self.boundingRect(with: CGSize(width: Double.greatestFiniteMagnitude, height: Double.greatestFiniteMagnitude), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil).size
    }
}
