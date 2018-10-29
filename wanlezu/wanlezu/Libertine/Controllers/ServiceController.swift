//
//  LoaderController.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

class ServiceController<T: BaseModel, C: UIView>: BaseController {
    public let cellID = "appCell"

    public var data: [[T]] = []

    public var endpoint: API = .none {
        didSet {
            Service<T>(api: endpoint).request().then { model -> Void in
                
            }.catch { error in
                self.serviceFailure(error: error)
            }
        }
    }

    public func serviceSuccess(item: T){}

    public func serviceFailure(error: Error){}

    // 子类重载
    public func willDisplay(_ cell: C, forRowAt indexPath: IndexPath, item: T) {}

    public func didSelectRow(at indexPath: IndexPath, item: T) {}
}
