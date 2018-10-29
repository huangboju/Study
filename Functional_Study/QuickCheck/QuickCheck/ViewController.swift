//
//  ViewController.swift
//  QuickCheck
//
//  Created by 伯驹 黄 on 2017/3/28.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//protocol Arbitrary {
//    static var arbitrary: Self { get }
//}

extension Int: Arbitrary {
    static var arbitrary: Int {
        return Int(arc4random())
    }
}

extension Int {
    static func arbitrary(in range: CountableRange<Int>) -> Int {
        let diff = range.upperBound - range.lowerBound
        return range.lowerBound + (Int.arbitrary % diff)
    }
}

extension UnicodeScalar: Arbitrary {
    static var arbitrary: UnicodeScalar {
        return UnicodeScalar(Int.arbitrary(in: 65..<90))!
    }
}

extension String: Arbitrary {
    static var arbitrary:  String {
        let randomLength = Int.arbitrary(in: 0..<40)
        let randomScalars = (0..<randomLength).map { _ in
            UnicodeScalar.arbitrary }
        return String(UnicodeScalarView(randomScalars))
    }
}

let numberOfIterations = 1000


func check1<A: Arbitrary>(_ message: String, _ property: (A) -> Bool) -> () {
    for _ in 0 ..< numberOfIterations {
        let value = A.arbitrary
        guard property(value) else {
            print ( " \"\( message)\" doesn't hold: \(value)")
            return
        }
    }
    print( " \"\( message)\" passed \(numberOfIterations) tests.")
}

extension CGSize {
    var area: CGFloat {
        return width * height
    }
}
extension CGSize: Arbitrary {
    static var arbitrary: CGSize {
        return CGSize(width: .arbitrary, height: .arbitrary)
    }
}


protocol Smaller {
    var smaller: Self? { get }
}

extension Int: Smaller {
    var smaller: Int? {
        return self == 0 ? nil : self / 2
    }
}

extension String: Smaller {
    var smaller: String? {
        return isEmpty ? nil : String(characters.dropFirst())
    }
}

protocol Arbitrary: Smaller {
    static var arbitrary: Self { get }
}
