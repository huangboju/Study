//
//  ListPresenter.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

protocol ListPresenter: class {
    associatedtype type: UIScrollView
    var listView: type! { set get }


    func addRefreshControl()
}

extension ListPresenter where Self: BaseController {
    func addRefreshControl() {
    
    }
}
