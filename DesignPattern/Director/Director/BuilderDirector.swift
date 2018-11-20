//
//  BuliderDirector.swift
//  Director
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

class BuilderDirector {

    private var bulider: Buildable!

    init(bulider: Buildable) {
        self.bulider = bulider
    }

    var constructProduct: String {
        bulider.buildHeader()
        bulider.buildBody()
        bulider.buildFooter()
        return bulider.getProduct
    }
}
