//
//  CollectionComponent.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class DemoTagsComponent: CollectionComponent {
    var tags: [String] = []
    
    private var refresh = false

    override init(tableView: UITableView, delegate: TableComponentDelegate) {
        super.init(tableView: tableView, delegate: delegate)
        
        title = "Suggestions"
        actionTitle = "Refresh"
    }
    
    override func reloadData(with tableView: UITableView, in section: Int) {
        if !refresh {
            refresh = true
            tags = [
                "C++",
                "C",
                "Objective-C",
                "Javascript",
                "CSS",
                "Swift",
                "Go",
                "Python",
                "PHP",
                "HTML"
            ]
        } else {
            refresh = false
            tags = [
                "NodeJS",
                "AngularJS",
                "Ruby",
                "Erlang",
                "MySQL"
            ]
        }
        collectionView?.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.setNeedUpdateHeight(for: section)
        }
    }

    override func heightForComponentItem(at index: Int) -> CGFloat {
        return ceil(max(44, collectionView!.contentSize.height + collectionView!.contentInset.top + collectionView!.contentInset.bottom))
    }
    
    override func configureCollectionView(_ collectionView: UICollectionView) {
        super.configureCollectionView(collectionView)
        
        collectionView.register(TextCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.scrollDirection = .vertical
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        (cell as? TextCollectionViewCell)?.text = tags[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag = tags[indexPath.item]
        var size = (tag as NSString).size(withAttributes: [NSAttributedStringKey.font: UIFont.preferredFont(forTextStyle: .body)])
        size.width += 16
        size.height += 8
        return size
    }
}
