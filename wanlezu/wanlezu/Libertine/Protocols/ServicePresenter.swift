//
//  ServicePresenter.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

protocol ServicePresenter: class {
    associatedtype model: BaseModel

//    var service: Service<model> { get }
    var data: [[model]] { set get }
}

