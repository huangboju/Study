//
//  Footer.swift
//  CollectionViewHoverHeaderFooter
//
//  Created by Dongbing Hou on 24/02/2017.
//  Copyright © 2017 redtwowolf. All rights reserved.
//

import UIKit

class Footer: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.green
        let footer = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        footer.text = "Footer"
        addSubview(footer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
