//
//  ViewController.swift
//  GreatController
//
//  Created by 伯驹 黄 on 2017/1/19.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    var arrayDataSource: ArrayDataSource<String>?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)

        tableView.tableFooterView = UIView()

        let photos = ["1", "2", "3"]
        arrayDataSource = ArrayDataSource(tableView, items: photos, cellIdentifier: "cell") { cell, item in
            cell.textLabel?.text = item
        }
        tableView.dataSource = arrayDataSource
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        print("fdsafd")
    }
}
