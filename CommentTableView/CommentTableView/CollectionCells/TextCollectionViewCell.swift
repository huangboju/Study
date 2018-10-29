//
//  TextCollectionViewCell.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit
import SnapKit

class TextCollectionViewCell: UICollectionViewCell {
    private let textLabel = UILabel()
    
    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 3.0
        layer.borderWidth = 1.0

        textLabel.font = UIFont.preferredFont(forTextStyle: .body)
        contentView.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView)
            make.width.lessThanOrEqualTo(contentView)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
