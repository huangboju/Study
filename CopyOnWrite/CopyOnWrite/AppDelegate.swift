//
//  AppDelegate.swift
//  CopyOnWrite
//
//  Created by 黄伯驹 on 2017/9/6.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

struct MyData {
    var _data: NSMutableData
    init(_ data: NSData) {
        self._data = data.mutableCopy() as! NSMutableData
    }
}

extension MyData {
    func append(_ other: MyData) {
        _data.append(other._data as Data)
    }
}

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        var arr: [Int] = []
        for _ in 0 ..< 100000 {
            let n = Int(arc4random_uniform(100000))
            arr.append(n)
        }
        
        
        let start = CACurrentMediaTime()
        let result = insertionSort(arr)
        print(CACurrentMediaTime() - start)
        
//        let theData = NSData(base64Encoded: "wAEP/w==", options: [])!
//        let x = MyData(theData)
//        let y = x
//        print(x._data === y._data)
        
        
        return true
    }
    
    func insertionSort(_ array: [Int]) -> [Int] {
        var a = array
        for x in 1..<a.count {
            var y = x
            let temp = a[y]
            while y > 0 && temp < a[y - 1] {
                a[y] = a[y - 1]                // 1
                y -= 1
            }
            a[y] = temp                      // 2
        }
        return a
    }
    
//    func insertionSort(_ array: [Int]) -> [Int] {
//        var a = array             // 1
//        for x in 1..<a.count {         // 2
//            var y = x
//            while y > 0 && a[y] < a[y - 1] { // 3
//                a.swapAt(y - 1, y)
//                y -= 1
//            }
//        }
//        return a
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

