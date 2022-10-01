//
//  main.swift
//  IPAddressToUInt32
//
//  Created by 黄伯驹 on 2017/10/11.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import Foundation

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^(radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}

func convertIPAddressToUInt32(_ ip: String) -> UInt32 {
    if ip.isEmpty {
        fatalError("ip is empty")
    }
    var result: UInt32 = 0
    var times = 3
    var number = ""
    let characters = Array(ip.characters)
    var errorChars: [Character] = []
    for (i, c) in characters.enumerated() {
        if c == "." {
            result += UInt32(number)! * UInt32(256 ^^ times)
            times -= 1
            if times < 0 {
                fatalError("wrong format")
            }
            number = ""
            errorChars.removeAll(keepingCapacity: true)
        } else {
            if UInt32("\(c)") == nil {
                if i > 0 {
                    errorChars.append(characters[i - 1])
                }
                errorChars.append(c)
            } else {
                if !errorChars.isEmpty && errorChars.first != "." {
                    fatalError("wrong format char=\(c) ip=\(ip) i=\(i)")
                }
                number.append(c)
            }
        }
    }
    result += UInt32(number)! * UInt32(256 ^^ times)
    return result
}

print(convertIPAddressToUInt32("172.168.5.1."))

print(convertIPAddressToUInt32("172.  168.5.1  "))
print(convertIPAddressToUInt32("172 .168.5.1"))

print(convertIPAddressToUInt32("172  .  168.5.1  "))

// wrong format
// print(convertIPAddressToUInt32("17 2.  168. 5.1"))
// print(convertIPAddressToUInt32("172.168.5.1."))
// print(convertIPAddressToUInt32("172..168.5.1."))























extension UInt32 {

    public var IPv4String: String {
        let ip = self

        let byte1 = UInt8(ip & 0xff)
        let byte2 = UInt8((ip>>8) & 0xff)
        let byte3 = UInt8((ip>>16) & 0xff)
        let byte4 = UInt8((ip>>24) & 0xff)
        return "\(byte1).\(byte2).\(byte3).\(byte4)"
    }
}
