//
//  BaseComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class BaseComponent: NSObject, TableComponent {
    weak var delegate: TableComponentDelegate?
    var tableView: UITableView?

    var cellIdentifier: String?
    var headerIdentifier, footerIdentifier: String?

    init(tableView: UITableView, delegate: TableComponentDelegate) {
        super.init()
        let className = "\(classForCoder)"
        cellIdentifier = "\(className)-Cell"
        headerIdentifier = "\(className)-Header"
        footerIdentifier = "\(className)-Footer"
        self.tableView = tableView
        self.delegate = delegate

        register(with: tableView)
    }

    func register(with tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier!)
    }

    func setNeedUpdateHeight(for section: Int) {
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.beforeWaiting.rawValue, false, 0) { (observer, activity) in
            self.tableView?.reloadData()
        }
        CFRunLoopAddObserver(CFRunLoopGetMain(), observer, .defaultMode)
    }


    // TableComponent
    var numberOfItems: Int {
        return 0
    }

    var heightForComponentHeader: CGFloat {
        return 0
    }

    var heightForComponentFooter: CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func heightForComponentItem(at index: Int) -> CGFloat {
        return 0
    }
    
    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
    }
    
    func didSelectItem(at index: Int) {
        delegate?.tableComponent(component: self, didTapItemAt: index)
    }
    
    func reloadData(with tableView: UITableView, in section: Int) {
        
    }

    func header(for tableView: UITableView) -> UIView? { return nil }
    func footer(for tableView: UITableView) -> UIView? { return nil }

    func willDisplayHeader(_ header: UIView) {}
    func willDisplayFooter(_ footer: UIView) {}
    func willDisplayCell(_ cell: UITableViewCell, for indexPath: IndexPath) {}
}
