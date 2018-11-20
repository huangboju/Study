//
//  XMLBuilder.swift
//  Director
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

class XMLBuilder: Buildable {
    private var data: String!

    init(data: String) {
        self.data = data
    }

    func buildHeader() {
        data = "\n<xml.headr>\n<body>\n" + data
    }

    func buildBody() {
        data = data + "\n<\\body>\n"
    }

    func buildFooter() {
        data = data + "<xml.footer>"
    }

    var getProduct: String {
        return data
    }
}
