//
//  Header.swift
//  CollectionViewHoverHeaderFooter
//
//  Created by Dongbing Hou on 24/02/2017.
//  Copyright © 2017 redtwowolf. All rights reserved.
//

import UIKit

class Header: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.cyan
        
        let header = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        header.text = "Header"
        addSubview(header)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
