//
//  ArrayDataSource.swift
//  GreatController
//
//  Created by 伯驹 黄 on 2017/1/19.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class ArrayDataSource<T>: NSObject, UITableViewDataSource {

    private var configureCellBlock: (_ cell: UITableViewCell, _ item: T) -> Void

    private var items: [T]
    private var cellIdentifier: String
    private var tableView: UITableView? {
        didSet {
            tableView?.dataSource = self
        }
    }

    init(_ view: UITableView, items: [T], cellIdentifier: String, configureCellBlock: @escaping ((_ cell: UITableViewCell, _ item: T) -> Void)) {
        tableView = view
        self.items = items
        self.cellIdentifier = cellIdentifier
        self.configureCellBlock = configureCellBlock
    }

    func item(at indexPath: IndexPath) -> T {
        return items[indexPath.row]
    }

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        configureCellBlock(cell, item(at: indexPath))
        return cell
    }
}
