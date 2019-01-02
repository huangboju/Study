//
//  ViewController.swift
//  JSCore_Study
//
//  Created by 黄伯驹 on 2017/7/23.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit
import JavaScriptCore

// http://www.cocoachina.com/ios/20170720/19958.html

class ViewController: UIViewController {
    
    private lazy var jsScript: String = {
        guard let testJSPath = Bundle.main.path(forResource: "test", ofType: "js") else { return "" }
        return try! String(contentsOfFile: testJSPath, encoding: .utf8)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()


        swiftToJS()
        
        excuteJSfile()

        jsConnectWithSwift()

        jsExport()
    }

    func swiftToJS() {
        
        /// JSContext 是JS代码的执行环境
        let jsContext: JSContext = JSContext()

        guard let jsValue = jsContext.evaluateScript("2 + 2") else { return }
        
        print("这是一个jsValue", jsValue.toInt32())
    }

    func excuteJSfile() {

        let jsContext: JSContext = JSContext()
        jsContext.evaluateScript(jsScript)

        guard let function = jsContext.objectForKeyedSubscript("factorial") else { return }
        
        guard let result = function.call(withArguments: [2]) else { return }

        print("这是执行JS方法后的值",result)
    }

    func jsConnectWithSwift() {
        let jsContext: JSContext = JSContext()
        jsContext.evaluateScript(jsScript)

        
        /// http://www.jianshu.com/p/f4dd6397ae86
        /*
         @convention(swift) : 表明这个是一个swift的闭包
         @convention(block) ：表明这个是一个兼容oc的block的闭包
         @convention(c) : 表明这个是兼容c的函数指针的闭包。
         */
        /// 注意： 
        /*
         1. 不要在Block中直接使用JSValue
         2. 不要在Block中直接使用JSContext
         因为Block会强引用它里面用到的外部变量，如果直接在Block中使用JSValue的话，那么这个JSvalue就会被这个Block强引用，而每个JSValue都是强引用着它所属的那个JSContext的，这是前面说过的，而这个Block又是注入到这个Context中，所以这个Block会被context强引用，这样会造成循环引用，导致内存泄露。不能直接使用JSContext的原因同理。
    
         那怎么办呢，针对第一点，建议把JSValue当做参数传到Block中，而不是直接在Block内部使用，这样Block就不会强引用JSValue了。
         
         针对第二点，可以使用[JSContext currentContext] 方法来获取当前的Context。
         */
        let handle: @convention(block) ([String: Any]) -> UIColor = { dict in
            print("js回调结果", dict)
            return UIColor(white: 0.7, alpha: 1)
        }

        // 将handle注入到context中，并起名字为makeNSColor，要与js中的回调名称一致
        jsContext.setObject(handle, forKeyedSubscript: "makeNSColor" as NSCopying & NSObjectProtocol)
        jsContext.evaluateScript("makeNSColor")

        guard let function = jsContext.evaluateScript("colorForWord") else { return }
        print(function.call(withArguments: ["red"]))
    }
    
    func jsExport() {
        let jsContext: JSContext = JSContext()
        jsContext.evaluateScript(jsScript)
        
        let item = Item(title: "我是swift中的title", text: "我是swift中的text")
        jsContext.setObject(Item.self, forKeyedSubscript: "Item" as NSCopying & NSObjectProtocol)
        let function = jsContext.objectForKeyedSubscript("jsExport")
        guard let jsItem = function?.call(withArguments: [item]).toObject() as? Item else { return }
        print(jsItem.title, jsItem.text)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

@objc protocol ItemJSExport: JSExport {
    var text: String { get set }
    var title: String { get set }

    static func itemWith(title: String, text: String) -> Item
}

class Item: NSObject, ItemJSExport {
    var title: String
    var text: String

    init(title: String, text: String) {
        self.title = title
        self.text = text
    }

    static func itemWith(title: String, text: String) -> Item {
        return Item(title: title, text: text)
    }
}

