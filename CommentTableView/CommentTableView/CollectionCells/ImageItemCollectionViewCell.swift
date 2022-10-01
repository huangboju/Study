//
//  ImageItemCollectionViewCell.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class ImageItemCollectionViewCell: UICollectionViewCell {

    let imageView = UIImageView()
    let nameLabel = UILabel()
    let detailLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 1
        
        imageView.contentMode = .scaleAspectFit
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(imageView.snp.width)
        }

        nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.width.lessThanOrEqualTo(contentView)
        }

        detailLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        contentView.addSubview(detailLabel)
        detailLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView)
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.bottom.lessThanOrEqualTo(contentView).offset(2)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
