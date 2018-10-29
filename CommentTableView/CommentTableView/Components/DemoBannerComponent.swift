//
//  DemoBannerComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class DemoBannerComponent: CollectionComponent {
    override init(tableView: UITableView, delegate: TableComponentDelegate) {
        super.init(tableView: tableView, delegate: delegate)
        title = "Banners"
        actionTitle = "More >"
    }
    
    override func configureCollectionView(_ collectionView: UICollectionView) {
        super.configureCollectionView(collectionView)
        
        collectionView.contentInset = .zero
        collectionView.isPagingEnabled = true

        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumInteritemSpacing = 0
        layout?.minimumLineSpacing = 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        var imageView = cell.contentView.viewWithTag(1001) as? UIImageView
        if imageView == nil {
            imageView = UIImageView(frame: cell.bounds)
            imageView?.contentMode = .scaleAspectFill
            imageView?.tag = 1001
            imageView?.layer.borderWidth = 0.5
            imageView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            cell.contentView.addSubview(imageView!)
        }

        imageView?.image = UIImage(named: "\(indexPath.item % 5 + 1)")

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
