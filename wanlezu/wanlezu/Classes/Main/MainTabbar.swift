//
//  MainTabbar.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

class MainTabbar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        delegate = self
        selectedIndex = 0
    }

    override var viewControllers: [UIViewController]? {
        didSet {
            let titles = ["Home", "Me"]
            for (i, item) in tabBar.items!.enumerated() {
                item.title = titles[i]
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MainTabbar: UITabBarControllerDelegate {

    func tabBarController(_: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
        if (viewController as? UINavigationController)?.topViewController is Me {
            let controller = UINavigationController(rootViewController: SignIn())
            present(controller, animated: true, completion: nil)
            return false
        }

        return true
    }
}
