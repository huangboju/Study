//
//  BaseModel.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import ObjectMapper

class BaseModel: Mappable {
    var base: String?
    var url: String?

    required init?(map _: Map) {
    }

    func mapping(map: Map) {
        base <- map["base"]
        url <- map["url"]
    }
}
