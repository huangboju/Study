//
//  HtmlBuilder.swift
//  Director
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

class HtmlBuilder: Buildable {
    var data: String!

    init(data: String) {
        self.data = data
    }

    func buildHeader() {
        data = "\n<html.headr>\n<body>\n" + data
    }

    func buildBody() {
        data = data + "\n<\\body>\n"
    }

    func buildFooter() {
        data = data + "<html.footer>"
    }

    var getProduct: String {
        return data
    }
}
