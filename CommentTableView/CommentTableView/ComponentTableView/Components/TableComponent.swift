//
//  TableComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

protocol TableComponentDelegate: class {
    func tableComponent(component: TableComponent, didTapItemAt index: Int)
}

extension TableComponentDelegate {
    func tableComponent(component: TableComponent, didTapItemAt index: Int) {}
}

protocol TableComponent: class {
    var cellIdentifier: String? { set get }
    var headerIdentifier: String? { set get }
    var footerIdentifier: String? { set get }
    
    var numberOfItems: Int { get }
    var heightForComponentHeader: CGFloat { get }
    var heightForComponentFooter: CGFloat { get }
    func heightForComponentItem(at index: Int) -> CGFloat

    func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell

    func reloadData(with tableView: UITableView, in section: Int)
    func register(with tableView: UITableView)
    
    // optional
    func header(for tableView: UITableView) -> UIView?
    func footer(for tableView: UITableView) -> UIView?
    
    func willDisplayHeader(_ header: UIView)
    func willDisplayFooter(_ footer: UIView)
    func willDisplayCell(_ cell: UITableViewCell, for indexPath: IndexPath)
    
    func didSelectItem(at index: Int)
}

extension TableComponent {
    func header(for tableView: UITableView) -> UIView? { return nil }
    func footer(for tableView: UITableView) -> UIView? { return nil }
    
    func willDisplayHeader(_ header: UIView) {}
    func willDisplayFooter(_ footer: UIView) {}
    func willDisplayCell(_ cell: UITableViewCell, for indexPath: IndexPath) {}
    
    func didSelectItem(at index: Int) {}
}
