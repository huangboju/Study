//
//  DemoItemComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class DemoItemComponent: MoreActionComponent {
    override init(tableView: UITableView, delegate: TableComponentDelegate) {
        super.init(tableView: tableView, delegate: delegate)
        
        title = "Items"
    }
    
    override func register(with tableView: UITableView) {
        super.register(with: tableView)
        
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: cellIdentifier!)
    }
    
    override var numberOfItems: Int {
        return 8
    }
    
    override func heightForComponentItem(at index: Int) -> CGFloat {
        return 64
    }
    
    override func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let _cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        let cell = _cell as? ItemTableViewCell
        cell?.imageView?.image = UIImage(named: "\(indexPath.row % 5 + 1)")
        cell?.textLabel?.text = "A awesome item"
        cell?.detailTextLabel?.text = "some descriptions here. some descriptions here. some descriptions here."
        return _cell
    }
}
