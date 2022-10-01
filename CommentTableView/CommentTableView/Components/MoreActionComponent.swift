//
//  MoreActionComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class MoreActionComponent: ActionHeaderComponent {
    override init(tableView: UITableView, delegate: TableComponentDelegate) {
        super.init(tableView: tableView, delegate: delegate)
        actionTitle = "More >"
    }
}
