//
//  HeaderComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class HeaderComponent: BaseComponent {
    var title: String?
    var titleFont: UIFont?
    var titleColor: UIColor?
    var accessoryView: UIView?
    
    override func register(with tableView: UITableView) {
        super.register(with: tableView)
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: headerIdentifier!)
    }

    override var heightForComponentHeader: CGFloat {
        return 36
    }

    override func header(for tableView: UITableView) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: headerIdentifier!) else {
            return nil
        }
        header.textLabel?.text = title
        header.textLabel?.textColor = titleColor ?? UIColor.darkGray
        accessoryView?.frame = accessoryRect(for: header.bounds)
        header.contentView.addSubview(accessoryView!)
        return header;
    }
    
    override func willDisplayHeader(_ header: UIView) {
        guard let headerView = header as? UITableViewHeaderFooterView else { return }
        headerView.textLabel?.font = titleFont ?? UIFont.preferredFont(forTextStyle: .headline)
        accessoryView?.frame = accessoryRect(for: header.bounds)
    }

    func accessoryRect(for bounds: CGRect) -> CGRect {
        let size = accessoryView?.sizeThatFits(bounds.size) ?? .zero
        return CGRect(x: bounds.width - size.width - 8, y: (bounds.height - size.height) / 2, width: size.width, height: size.height)
    }
}
