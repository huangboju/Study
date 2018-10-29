//
//  AppDelegate.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        initApp()

        AppConfigurationTemplate.setupConfigurationTemplate()
        return true
    }

    func initApp() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        let mainTabbar = MainTabbar()
        mainTabbar.viewControllers = [Home(), Me()].map { UINavigationController(rootViewController: $0)
        }
        window?.rootViewController = mainTabbar
        window?.makeKeyAndVisible()
    }

    func applicationWillResignActive(_: UIApplication) {
    }

    func applicationDidEnterBackground(_: UIApplication) {
    }

    func applicationWillEnterForeground(_: UIApplication) {
    }

    func applicationDidBecomeActive(_: UIApplication) {
    }

    func applicationWillTerminate(_: UIApplication) {
    }
}
