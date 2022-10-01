//
//  ItemTableViewCell.swift
//  CommentTableView
//
//  Created by 黄伯驹 on 2017/10/15.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        textLabel?.textColor = UIColor.darkText
        detailTextLabel?.font = UIFont.preferredFont(forTextStyle: .caption2)
        detailTextLabel?.numberOfLines = 0
        detailTextLabel?.textColor = UIColor.gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let height = contentView.bounds.height - 8 * 2
        imageView?.frame = CGRect(x: 8, y: 8, width: height, height: height)
        
        let imageViewMaxX = imageView?.frame.maxX ?? 0
        
        let width = contentView.bounds.width - imageViewMaxX - 8
        textLabel?.preferredMaxLayoutWidth = width
        textLabel?.sizeToFit()
        
        textLabel?.frame = CGRect(x: imageViewMaxX + 8, y: 8, width: width, height: textLabel!.frame.height)

        detailTextLabel?.preferredMaxLayoutWidth = width
        detailTextLabel?.sizeToFit()
        detailTextLabel?.frame = CGRect(x: imageViewMaxX + 8, y: textLabel!.frame.maxY + 4, width: width, height: detailTextLabel!.frame.height)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
