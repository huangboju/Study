//
//  DemoStyle2ViewController.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class DemoStyle2ViewController: ComponentController, ActionHeaderComponentDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()

        components = [
            DemoImageItemComponent(tableView: tableView, delegate: self)
        ]
    }
}
