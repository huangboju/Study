//
//  DemoImageItemComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class DemoImageItemComponent: CollectionComponent {
    override init(tableView: UITableView, delegate: TableComponentDelegate) {
        super.init(tableView: tableView, delegate: delegate)
        title = "Photo"
        actionTitle = "Share"
    }
    
    override func configureCollectionView(_ collectionView: UICollectionView) {
        super.configureCollectionView(collectionView)
        
        collectionView.register(ImageItemCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.itemSize = CGSize(width: 120, height: 164)
    }
    
    override func heightForComponentItem(at index: Int) -> CGFloat {
        return 180
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let _cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let cell = _cell as? ImageItemCollectionViewCell
        cell?.imageView.image = UIImage(named: "\(indexPath.item % 5 + 1)")
        cell?.nameLabel.text = "Picture"
        cell?.detailLabel.text = "Descriptions"
        return _cell
    }
}
