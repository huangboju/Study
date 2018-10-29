//
//  Service.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Moya
import ObjectMapper
import PromiseKit

struct Service<T: BaseModel> {
    private let provider = MoyaProvider<API>(plugins: [RequestLoading()])
    let api: API

    func request() -> Promise<T> {
       let promise = Promise<T>(resolvers: { fulfill, reject in
                Promise<Any?>(resolvers: { success, failure in
                    provider.request(api) { result in
                        switch result {
                        case let .success(r):
                            success(try? r.mapJSON())
                        case let .failure(e):
                            failure(e)
                        }
                    }
                }).then { (json) -> Void in
                    // 网络成功
                    if let map = Mapper<T>().map(JSONObject: json) {
                        fulfill(map)
                    } else {
                        // 解析失败
                        reject(NSError(domain: "解析错误", code: 6006, userInfo: nil))
                    }
                }.catch { error  in
                    // 网络失败
                    reject(error)
                }
        })
        return promise
    }
}
