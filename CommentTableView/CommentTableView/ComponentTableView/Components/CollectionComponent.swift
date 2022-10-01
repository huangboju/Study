//
//  CollectionComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class CollectionComponent: ActionHeaderComponent {
    open var collectionView: UICollectionView?
    
    override init(tableView: UITableView, delegate: TableComponentDelegate) {
        super.init(tableView: tableView, delegate: delegate)
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.scrollDirection = .horizontal

        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

        configureCollectionView(collectionView!)

        collectionView?.delegate = self
        collectionView?.dataSource = self
    }

    override func reloadData(with tableView: UITableView, in section: Int) {
        collectionView?.reloadData()
    }
    
    override var numberOfItems: Int {
        return 1
    }

    override func heightForComponentItem(at index: Int) -> CGFloat {
        return 160
    }
    
    override func didSelectItem(at index: Int) {
        
    }
    
    override func cell(for tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier!, for: indexPath)
        cell.selectionStyle = .none
        collectionView?.frame = collectionViewRect(for: cell.bounds)
        cell.contentView.addSubview(collectionView!)
        return cell
    }

    func configureCollectionView(_ collectionView: UICollectionView) {
        collectionView.contentInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        collectionView.backgroundColor = UIColor.clear
        collectionView.scrollsToTop = false

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    }
    

    func collectionViewRect(for bounds: CGRect) -> CGRect {
        return bounds
    }
}

extension CollectionComponent: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
    }
}

extension CollectionComponent: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.tableComponent(component: self, didTapItemAt: indexPath.row)
    }
}
