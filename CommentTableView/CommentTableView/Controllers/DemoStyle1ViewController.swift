//
//  DemoStyle1ViewController.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class DemoStyle1ViewController: ComponentController, ActionHeaderComponentDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        components = [
            DemoItemComponent(tableView: tableView, delegate: self)
        ]
    }
}
