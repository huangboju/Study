//
//  main.swift
//  Proxy
//
//  Created by 伯驹 黄 on 2017/2/15.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

protocol Icon {
    var iconWidth: CGFloat { get }
    var iconHeight: CGFloat { get }
    func paintIcon()
}

class ImageIcon: Icon {
    var iconWidth: CGFloat {
        return 320
    }

    var iconHeight: CGFloat {
        return 568
    }

    func paintIcon() {
    }
}

class ImageProxy: Icon {
    var imageIcon: ImageIcon?
    var imageUrl: URL?
    var retrieving = false

    init(url: URL) {
        imageUrl = url
    }

    var iconWidth: CGFloat {
        guard let imageIcon = imageIcon else {
            return 600
        }
        return imageIcon.iconHeight
    }

    var iconHeight: CGFloat {
        guard let imageIcon = imageIcon else {
            return 600
        }
        return imageIcon.iconHeight
    }

    func paintIcon() {
    }
}

// MARK: - Protection Proxy

protocol DoorOperator {
    func open(doors: String) -> String
}

class HAL9000: DoorOperator {
    func open(doors: String) -> String {
        return ("HAL9000: Affirmative, Dave. I read you. Opened \(doors).")
    }
}

class CurrentComputer: DoorOperator {
    private var computer: HAL9000!

    func authenticate(password: String) -> Bool {

        guard password == "pass" else {
            return false
        }

        computer = HAL9000()

        return true
    }

    func open(doors: String) -> String {

        guard computer != nil else {
            return "Access Denied. I'm afraid I can't do that."
        }

        return computer.open(doors: doors)
    }
}

let computer = CurrentComputer()
let podBay = "Pod Bay Doors"

print(computer.open(doors: podBay))

print(computer.authenticate(password: "pass"))
print(computer.open(doors: podBay))

// MARK: - Virtual Proxy

protocol HEVSuitMedicalAid {
    func administerMorphine() -> String
}

class HEVSuit: HEVSuitMedicalAid {
    func administerMorphine() -> String {
        return "Morphine aministered."
    }
}

class HEVSuitHumanInterface: HEVSuitMedicalAid {
    private lazy var physicalSuit: HEVSuit = HEVSuit()

    func administerMorphine() -> String {
        return physicalSuit.administerMorphine()
    }
}

let humanInterface = HEVSuitHumanInterface()
print(humanInterface.administerMorphine())

// MARK: - ====================================

protocol PersonBean {
    var name: String? { set get }
    var gender: String? { set get }
    var interests: String? { set get }
    var hotOrNotRating: Int { set get }
}

class PersonBeanImpl: PersonBean {
    var interests: String?
    var gender: String?
    var name: String?
    var rating = 0
    var ratingCout = 0
    var hotOrNotRating: Int {
        set {
            rating += rating
            ratingCout += ratingCout
        }
        get {
            return ratingCout == 0 ? 0 : rating / ratingCout
        }
    }
}

// MARK: - ====================================

protocol OrderInterface {
    func change(productName: String, operator: String)
    func queryOrder()
}

class Order: OrderInterface {
    var orderOperator: String?
    var productName: String?
    var productAmount = 0
    var orderSignTime: String?

    init(name: String, orderOperator: String, amount: Int, time: String) {
        self.orderOperator = orderOperator
        productName = name
        productAmount = amount
        orderSignTime = time
    }

    func change(productName: String, operator _: String) {
        self.productName = productName
    }

    func queryOrder() {
        print("\(productName)订单名字：\(orderOperator)订单操作员：\(productAmount) 订单数量：%zd\n 订单签订时间：\(orderSignTime)")
    }
}
