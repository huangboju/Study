//
//  main.swift
//  ReversePolish
//
//  Created by 黄伯驹 on 2018/4/25.
//  Copyright © 2018 黄伯驹. All rights reserved.
//

import Foundation

enum RPNElement {
    case operand(Double)
    case `operator`(String, (Double, Double) -> Double)
}

extension String {
    func toRPNElement() -> RPNElement {
        switch self {
        case "*": return .operator(self, { $0 * $1 })
        case "+": return .operator(self, { $0 + $1 })
        case "-": return .operator(self, { $0 - $1 })
        case "/": return .operator(self, { $0 / $1 })
        default: return .operand(Double(self)!)
        }
    }
}

func stringToRPNElement(s: String) -> RPNElement {
    return s.toRPNElement()
}

func solveRPN(_ expression: String) -> Double {
    let componets = expression.components(separatedBy: " ")
    let elements = componets.map(stringToRPNElement)
    let results = elements.reduce([]) { (acc: [Double], e: RPNElement) -> [Double]  in
        switch e {
        case .operand(let operand):
            return [operand] + acc
        case .operator(_, let f):
            let r = f(acc[0], acc[1])
            return [r] + acc[2..<acc.count]
        }
    }
    return results.first ?? 0
}
print(solveRPN("3 5 + 2 *"))

