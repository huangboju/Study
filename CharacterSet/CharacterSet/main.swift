//
//  main.swift
//  CharacterSet
//
//  Created by 伯驹 黄 on 2017/3/20.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

// http://nshipster.cn/nscharacterset/
// http://www.cnblogs.com/limicheng/p/4180335.html
// http://blog.csdn.net/lcl130/article/details/41802623

 var string1 = "Lorem    ipsum dolar   sit  amet."

 string1 = string1.trimmingCharacters(in: .whitespaces)

print(string1)

 let components = string1.components(separatedBy: .whitespaces)

//components.filter(NSPredicate(fromMetadataQueryString: "self <> ''"))
// components = [components filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"self <> ''"]]

 string1 = components.joined(separator: " ")

let string = "Mon-Thurs:  8:00 - 18:00Fri:        7:00 - 17:00Sat-Sun:    10:00 - 15:00"

var skippedCharacters = CharacterSet()
skippedCharacters.formIntersection(.punctuationCharacters)
skippedCharacters.formIntersection(.whitespaces)

var startDay, endDay: NSString?
string.enumerateLines { line, _ in
    let scanner = Scanner(string: line)
    scanner.charactersToBeSkipped = skippedCharacters

    
    var startHour: Int = 0
    var startMinute: Int = 0
    var endHour: Int = 0
    var endMinute: Int = 0

    scanner.scanCharacters(from: .letters, into: &startDay)
    scanner.scanCharacters(from: .letters, into: &endDay)

    scanner.scanInt(&startHour)
    scanner.scanInt(&startMinute)
    scanner.scanInt(&endHour)
    scanner.scanInt(&endMinute)
    
}

print(startDay)

func trimmedNumber(s: String) -> String {
    let characterSet = Set("+*#0123456789".characters)
    return String(s.characters.lazy.filter(characterSet.contains))
}

print(trimmedNumber(s: string))

let text = "**五分**, 今天天气好晴朗**四份**，你好啊**哈哈**"
let set = CharacterSet(charactersIn: "**")
let result = text.components(separatedBy: set)
print(result)





