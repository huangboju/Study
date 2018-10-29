//
//  Section+App.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/15.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Eureka

extension Section {
    var headerView: UIView? {
        return header?.viewForSection(self, type: .header)
    }
}

extension FieldRow {
    var text: String? {
        return cell.textField.text
    }
}
