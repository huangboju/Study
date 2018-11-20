//
//  Test.swift
//  GreatController
//
//  Created by 伯驹 黄 on 2017/6/22.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class Test: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        navigationController?.pushViewController(ViewController(), animated: true)
    }
}
