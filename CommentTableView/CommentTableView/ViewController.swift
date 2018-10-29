//
//  ViewController.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class ViewController: ComponentController, ActionHeaderComponentDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        let tags = DemoTagsComponent(tableView: tableView, delegate: self)

        components = [
            tags,
            DemoImageItemComponent(tableView: tableView, delegate: self),
            DemoBannerComponent(tableView: tableView, delegate: self),
            DemoImageItemComponent(tableView: tableView, delegate: self),
            DemoItemComponent(tableView: tableView, delegate: self)
        ]

        tags.reloadData(with: tableView, in: 0)
    }
    
    func tableComponent(component: TableComponent, didTapItemAt index: Int) {
        print(component)
    }

    func tableComponent(_ component: TableComponent, didTapActionButton button: UIButton) {
        if component is DemoTagsComponent {
            component.reloadData(with: tableView, in: 0)
        } else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

