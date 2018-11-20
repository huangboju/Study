//
//  main.swift
//  ChainOfResponsibility
//
//  Created by 伯驹 黄 on 2017/3/17.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Foundation

class Level {
    private var level = 0
    public init(level: Int) {
        self.level = level
    }

    func above(_ level: Level) -> Bool {
        return self.level >= level.level
    }
}

class Request {
    private(set) var level: Level!

    public init(level: Level) {
        self.level = level
    }
}

class Response {
}

class Handler {
    private var nextHandler: Handler!

    var level: Level {
        return Level(level: 0)
    }

    public final func handleRequest(_ request: Request) -> Response? {
        var response: Response?

        if level.above(request.level) {
            response = self.response(request)
        } else {
            if let nextHandler = nextHandler {
                nextHandler.handleRequest(request)
            } else {
                print("-----没有合适的处理器-----")
            }
        }
        return response
    }

    public func setNextHandler(_ handler: Handler) {
        nextHandler = handler
    }

    public func response(_: Request) -> Response? {
        return nil
    }
}

class ConcreteHandler1: Handler {
    override var level: Level {
        return Level(level: 1)
    }

    public override func response(_: Request) -> Response? {
        print("-----请求由处理器1进行处理-----")
        return nil
    }
}

class ConcreteHandler2: Handler {
    override var level: Level {
        return Level(level: 3)
    }

    public override func response(_: Request) -> Response? {
        print("-----请求由处理器2进行处理-----")
        return nil
    }
}

class ConcreteHandler3: Handler {
    override var level: Level {
        return Level(level: 5)
    }

    public override func response(_: Request) -> Response? {
        print("-----请求由处理器3进行处理-----")
        return nil
    }
}

let handler1 = ConcreteHandler1()
let handler2 = ConcreteHandler2()
let handler3 = ConcreteHandler3()

handler1.setNextHandler(handler2)
handler2.setNextHandler(handler3)

let response = handler1.handleRequest(Request(level: Level(level: 4)))

class Handler1 {
    var successor: Handler1?

    func handleRequest(fee _: Int) {
    }
}

class ProjectManagerHandler: Handler1 {
    override func handleRequest(fee: Int) {
        if fee < 500 {
            print("项目经理同意了费用申请")
        } else {
            if let successor = successor {
                print("项目经理没有权限批准，转到部门经理处理")
                successor.handleRequest(fee: fee)
            }
        }
    }
}

class SepManagerHandler: Handler1 {
    override func handleRequest(fee: Int) {
        if 500 ..< 1000 ~= fee {
            print("部门经理同意了费用申请")
        } else {
            if let successor = successor {
                print("部门经理没有权限批准，转到总经理处理")
                successor.handleRequest(fee: fee)
            }
        }
    }
}

class GeneralManagerHandler: Handler1 {
    override func handleRequest(fee _: Int) {
        print("总经理同意了费用申请")
    }
}

let handler_1 = ProjectManagerHandler()
let handler_2 = SepManagerHandler()
let handler_3 = GeneralManagerHandler()

// 设置责任链中的下一个处理对象
handler_1.successor = handler_2
handler_2.successor = handler_3

handler_1.handleRequest(fee: 100)

print("----------------------------------")
handler_1.handleRequest(fee: 700)

print("----------------------------------")
handler_1.handleRequest(fee: 10000)
