//
//  Buildable.swift
//  Director
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

protocol Buildable {
    func buildHeader()
    func buildBody()
    func buildFooter()

    var getProduct: String { get }
}
