//
//  ViewController.swift
//  WKWebViewDemo
//
//  Created by 伯驹 黄 on 2017/6/12.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit
import WebKit
import ContactsUI

let DAWebViewDemoScheme = "darkangel"
let DAWebViewDemoHostSmsLogin = "smsLogin"
let DAServerSessionCookieName = "DarkAngelCookie"
let DAUserDefaultsCookieStorageKey = "DAUserDefaultsCookieStorageKey"
let DAURLProtocolHandledKey = "DAURLProtocolHandledKey"

// http://www.saitjr.com/ios/ios-wkwebview-new-features-and-use.html
// http://www.jianshu.com/p/870dba42ec15

class ViewController: UIViewController {
    
    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let userContentController = WKUserContentController()
        
        //添加js全局变量
        let globalScript = WKUserScript(source: "var interesting = 123", injectionTime: .atDocumentStart, forMainFrameOnly: false)
        userContentController.addUserScript(globalScript)

        //页面加载完成立刻回调，获取页面上的所有Cookie
        let cookieScript = WKUserScript(source: "                window.webkit.messageHandlers.currentCookies.postMessage(document.cookie)", injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        userContentController.addUserScript(cookieScript)

        //alert Cookie
        let alertCookieScript = WKUserScript(source: "alert(document.cookie)", injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        userContentController.addUserScript(alertCookieScript)

        //添加自定义的cookie
        let newCookieScript = WKUserScript(source: "document.cookie = 'DarkAngelCookie=DarkAngel'", injectionTime: .atDocumentStart, forMainFrameOnly: false)
        userContentController.addUserScript(newCookieScript)


        //注册回调
        let names = [
            "share",
            "currentCookies",
            "shareNew"
        ]
        names.forEach {
           userContentController.add(self, name: $0)
        }


        let configuration = WKWebViewConfiguration()
        configuration.userContentController = userContentController
        
        
        webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsLinkPreview = true //允许链接3D Touch
        webView.customUserAgent = "WebViewDemo/1.0.0"    //自定义UA
//        webView.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0)
        //史诗级神坑，为何如此写呢？参考https://opensource.apple.com/source/WebKit2/WebKit2-7600.1.4.11.10/ChangeLog   以及我博客中的介绍
//        webView.setValue(webView.scrollView.contentInset, forKey: "_obscuredInsets")

        view.addSubview(webView)
        
        // 更新webView的cookie
//        updateWebViewCookie()
        
        // 图片添加点击事件
        imgAddClickEvent()
        
        // 添加NativeApi
        addNativeApiToJS()
        
        
        let path = Bundle.main.path(forResource: "test", ofType: "html")

        webView.load(URLRequest(url: URL(fileURLWithPath: path!)))

//        loadUrl("http://m.baidu.com/")
    }
    
    /**
     解决首次加载页面Cookie带不上问题
     
     @param url 链接
     */
    func loadUrl(_ url: String) {

        let request = URLRequest(url: URL(string: url)!)
        webView.load(fixRequest(request))
    }

    /*!
     *  更新webView的cookie
     */
    func updateWebViewCookie() {
        
        let cookieScript = WKUserScript(source: cookieString, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        //添加Cookie
        webView.configuration.userContentController.addUserScript(cookieScript)
    }

    
    var jsSource: String?

    /**
     页面中的所有img标签添加点击事件
     */
    func imgAddClickEvent() {

        if jsSource != nil {
            return
        }

        //防止频繁IO操作，造成性能影响
        let path = Bundle.main.path(forResource: "ImgAddClickEvent", ofType: "js")!

        jsSource = try? String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)

        //添加自定义的脚本
        let js = WKUserScript(source: jsSource!, injectionTime: .atDocumentEnd, forMainFrameOnly: false)
        webView.configuration.userContentController.addUserScript(js)
        //注册回调
        webView.configuration.userContentController.add(self, name: "imageDidClick")
    }
    
    var nativejsSource: String?
    
    /**
     添加native端的api
     */
    func addNativeApiToJS() {
        
        if nativejsSource != nil {
            return
        }

        let path = Bundle.main.path(forResource: "NativeApi", ofType: "js")!

        nativejsSource = try? String(contentsOf: URL(fileURLWithPath: path), encoding: .utf8)

        //添加自定义的脚本
        let js = WKUserScript(source: nativejsSource!, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        webView.configuration.userContentController.addUserScript(js)
        //注册回调
        webView.configuration.userContentController.add(self, name: "nativeShare")
        webView.configuration.userContentController.add(self, name: "nativeChoosePhoneContact")
    }

    var cookieString: String {
        var script = ""

        for cookie in HTTPCookieStorage.shared.cookies! {
            // Skip cookies that will break our script
            if (cookie.value as NSString).range(of: "'").location != NSNotFound {
                continue
            }
            // Create a line that appends this cookie to the web view's document's cookies
            script.append("document.cookie='\(cookie.da_javascriptString)' \n")
        }
        return script
    }

    var completion: ((_ name: String, _ phone: String) -> Void)?

    // MARK: - 选择联系人
    func selectContactCompletion(_ completion: ((_ name: String, _ phone: String) -> Void)?) {
        self.completion = completion

        let picker = CNContactPickerViewController()
        picker.delegate = self
        picker.displayedPropertyKeys = [CNContactPhoneNumbersKey]
        present(picker, animated: true, completion: nil)
    }
    
    /**
     修复打开链接Cookie丢失问题
     
     @param request 请求
     @return 一个fixedRequest
     */
    func fixRequest(_ request: URLRequest) -> URLRequest {
        var fixedRequest = request
        //防止Cookie丢失

        let dict = HTTPCookie.requestHeaderFields(with: HTTPCookieStorage.shared.cookies!)
        if !dict.isEmpty {
            var mDict = request.allHTTPHeaderFields

            for key in (mDict?.keys)! {
                mDict?[key] = dict[key]
            }

            fixedRequest.allHTTPHeaderFields = mDict
        }
        return fixedRequest
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        let names = [
            "share",
            "currentCookies",
            "shareNew",
            "imageDidClick",
            "nativeShare",
            "nativeChoosePhoneContact"
        ]

        names.forEach {
            webView.configuration.userContentController.removeScriptMessageHandler(forName: $0)
        }
    }

}

extension ViewController: CNContactPickerDelegate {
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contactProperty: CNContactProperty) {

        if contactProperty.key != CNContactPhoneNumbersKey {
            return
        }
        let contact = contactProperty.contact
        let name = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
        
        let phoneNumber = contactProperty.value as? CNPhoneNumber
        let phone = phoneNumber?.stringValue ?? ""
        //可以把-、+86、空格这些过滤掉

        var phoneStr = phone.replacingOccurrences(of: "-", with: "")
        phoneStr = phoneStr.replacingOccurrences(of: "+86", with: "")
        phoneStr = phoneStr.replacingOccurrences(of: " ", with: "")

        phoneStr = phoneStr.components(separatedBy: CharacterSet(charactersIn: "0123456789").inverted).joined(separator: "")

        //回调
        completion?(name, phoneStr)

        //dismiss
        picker.dismiss(animated: true, completion: nil)
    }
}


extension ViewController: WKNavigationDelegate {
    // 针对一次action来决定是否允许跳转，允许与否都需要调用decisionHandler，比如decisionHandler(WKNavigationActionPolicyCancel)
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Swift.Void) {
        //可以通过navigationAction.navigationType获取跳转类型，如新链接、后退等
        
        let URL = navigationAction.request.url
        //判断URL是否符合自定义的URL Scheme

        if URL?.scheme == DAWebViewDemoScheme {
            //根据不同的业务，来执行对应的操作，且获取参数
            if URL?.host == DAWebViewDemoHostSmsLogin {
                let param = URL?.query
                print("短信验证码登录, 参数为\(param)")
                decisionHandler(.cancel)
                return
            }
        }
        
        // important 这里很重要
        // 解决Cookie丢失问题
        let originalRequest = navigationAction.request

//        fixRequest(originalRequest)

        //如果originalRequest就是NSMutableURLRequest, originalRequest中已添加必要的Cookie，可以跳转
        //允许跳转
        decisionHandler(.allow)
        
        print(#function)
    }
    
    // 根据response来决定，是否允许跳转，允许与否都需要调用decisionHandler，如decisionHandler(WKNavigationResponsePolicyAllow);
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void) {
        print(#function)
        decisionHandler(.allow)
    }
    
    // 提交了一个跳转，早于 didStartProvisionalNavigation
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print(#function)
    }
    
    // 开始加载，对应UIWebView的- (void)webViewDidStartLoad:(UIWebView *)webView;
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        print(#function)
    }

    // 加载成功，对应UIWebView的- (void)webViewDidFinishLoad:(UIWebView *)webView;
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {

        // 关闭放大镜和复制按钮 http://www.cnblogs.com/cranz-jf/p/5412887.html
        webView.evaluateJavaScript("document.documentElement.style.webkitUserSelect='none';", completionHandler: nil)
        webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none';", completionHandler: nil)

        navigationItem.title = title?.appending(webView.title!)  //其实可以kvo来实现动态切换title
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        //    self.webView.scrollView.frame = CGRectMake(0, 64, self.webView.scrollView.frame.size.width, self.webView.scrollView.frame.size.height);
        //    self.webView.scrollView.contentOffset = CGPointMake(0, -64);
        
        //    [self.webView evaluateJavaScript:@"document.title" completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        //
        //    }];
        print(#function)
    }
    
    // 页面加载失败或者跳转失败，对应UIWebView的- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print(#function, error)
    }
    
    // 页面加载数据时报错
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        print(#function, error)
    }
}

extension ViewController: WKUIDelegate {
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        //这里不打开新窗口
        webView.load(fixRequest(navigationAction.request))
        return nil
    }
    
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        //js 里面的alert实现，如果不实现，网页的alert函数无效
        
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "确定", style: .cancel) { (_) in
            completionHandler()
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        //  js 里面的alert实现，如果不实现，网页的alert函数无效  ,
        let alertController = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "确定", style: .cancel) { (_) in
            completionHandler(true)
        }
        alertController.addAction(ok)
        
        let cancel = UIAlertAction(title: "取消", style: .cancel) { (_) in
            completionHandler(false)
        }
        alertController.addAction(cancel)

        present(alertController, animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alertController = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "确定", style: .cancel) { (_) in
            let textField = alertController.textFields?.first
            completionHandler(textField?.text)
        }
        alertController.addAction(ok)

        let cancel = UIAlertAction(title: "取消", style: .cancel) { (_) in
            completionHandler(nil)
        }
        alertController.addAction(cancel)

        alertController.addTextField { field in
            field.text = defaultText
        }
        present(alertController, animated: true, completion: nil)
    }
}

extension ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        let name = message.name
        if name == "share" {
            let body = message.body as? [String: Any]
            print("share分享的内容为：\(body)")
        } else if name == "shareNew" || name == "nativeShare" {
            let shareData = message.body as? [String: Any]
            print("\(name)分享的数据为： \(shareData)")
            //模拟异步回调
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                //读取js function的字符串
                let jsFunctionString = shareData?["result"] as? String ?? ""
                //拼接调用该方法的js字符串
                let callbackJs = "(\(jsFunctionString))(\(false));"    //后面的参数NO为模拟分享失败
                //执行回调

                self.webView.evaluateJavaScript(callbackJs, completionHandler: { (result, error) in
                    if error == nil {
                        NSLog("模拟回调，分享失败")
                    }
                })
            }
        } else if name == "currentCookies" {
            let cookiesStr = message.body as? String
            print("当前的cookie为： \(cookiesStr)")
        } else if name == "imageDidClick" {
            //点击了html上的图片
            print("点击了html上的图片，参数为\(message.body)")
            /*
             会log
             
             点击了html上的图片，参数为{
             height = 168;
             imgUrl = "http://cc.cocimg.com/api/uploads/170425/b2d6e7ea5b3172e6c39120b7bfd662fb.jpg";
             imgUrls =     (
             "http://cc.cocimg.com/api/uploads/170425/b2d6e7ea5b3172e6c39120b7bfd662fb.jpg"
             );
             index = 0;
             width = 252;
             x = 8;
             y = 8;
             }
             
             注意这里的x，y是不包含自定义scrollView的contentInset的，如果要获取图片在屏幕上的位置：
             x = x + contentInset.left;
             y = y + contentInset.top;
             */
            let dict = message.body as? [String: Any]
            let selectedImageUrl = dict?["imgUrl"] as? String
            let x = (dict?["x"] as? CGFloat)! + webView.scrollView.contentInset.left
            let y = (dict?["y"] as? CGFloat)! + webView.scrollView.contentInset.top
            let width = dict?["width"] as? CGFloat ?? 0
            let height = dict?["height"] as? CGFloat ?? 0
            let frame = CGRect(x: x, y: y, width: width, height: height)
            let index = dict?["index"] as? Int

            print("点击了第\(index)个图片，\n链接为\(selectedImageUrl)，\n在Screen中的绝对frame为\(frame)，\n所有的图片数组为\(dict?["imgUrls"])")
            
        } else if name == "nativeChoosePhoneContact" { //选择联系人
            print("正在选择联系人")

            selectContactCompletion({ (name, phone) in
                print("选择完成", name, phone)
                //读取js function的字符串
                let dict = message.body as? [String: Any]
                let jsFunctionString = dict?["completion"] as? String ?? ""
                //拼接调用该方法的js字符串
                
                /*
                 (function (res) {
                 contactInfo.innerHTML = JSON.stringify(res);
                 })({name: 'Kate Bell', mobile: '5555648583'});
                 */

                let callbackJs = "(\(jsFunctionString))({name: '\(name)', mobile: '\(phone)'});"
                print(callbackJs)
                //执行回调
                self.webView.evaluateJavaScript(callbackJs, completionHandler: { (_, _) in
                    
                })
            })
        }
    }
}

extension HTTPCookie {
    var da_javascriptString: String {
        var string = "\(name)=\(value)domain=\(domain)path=\(path.isEmpty ? "/" : path)"
        if isSecure {
            string += "secure=true"
        }
        return string
    }
}

