//
//  ChageVariableViewController.swift
//  RunTime
//
//  Created by 伯驹 黄 on 2016/11/18.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class ChageVariableViewController: UIViewController, UISetable {

    var xiaoMing: Person?

    var textLabel: UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()

        let str = "Teacher: What's your name?\nXiaoMing: My name is XiaoMing.\nTeacher: Pardon"
        creatingTextLabel(str)

        xiaoMing = Person()
        xiaoMing?.englishName = "xiao"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("😄")
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        answer()
    }

    func answer() {
        print(xiaoMing!.englishName!)
        var count: UInt32 = 0
        if let ivars = class_copyIvarList(xiaoMing?.classForCoder, &count) {
            print("😄")
            for i in 0 ..< Int(count) {
                if let ivar = ivars[i] {
                    let varName = ivar_getName(ivar)
                    let name = String(utf8String: varName!)
                    if name == "englishName" {
                        object_setIvar(xiaoMing, ivar, "✈️")
                        break
                    }
                }
            }
        }

        print(xiaoMing!.englishName!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
