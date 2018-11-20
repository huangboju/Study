//
//  main.swift
//  Director
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import Foundation

var builder: Buildable!

let data = "生产者模式实践"
builder = HtmlBuilder(data: data)
builder = XMLBuilder(data: data)
let director = BuilderDirector(bulider: builder)
let str = director.constructProduct
print(str)
