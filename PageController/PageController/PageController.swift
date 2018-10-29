//
//  PageController.swift
//  PageController
//
//  Created by 伯驹 黄 on 2017/3/10.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class PageController: UIViewController {

    private lazy var pageViewController: UIPageViewController = {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: [UIPageViewControllerOptionInterPageSpacingKey: 8])
        // 设置UIPageViewController代理和数据源
        pageViewController.delegate = self
        pageViewController.dataSource = self
        return pageViewController
    }()

    var pageContents: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(white: 0.8, alpha: 1)
        (0 ..< 10).forEach {
            pageContents.append("This is the page \($0) of content displayed using UIPageViewController")
        }

        let initialViewController = controller(at: 0) ?? ContentViewController()
        pageViewController.setViewControllers([initialViewController], direction: .forward, animated: false, completion: nil)

        pageViewController.view.frame = view.bounds
        addChildViewController(pageViewController)
        view.addSubview(pageViewController.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func controller(at index: Int) -> ContentViewController? {
        if pageContents.isEmpty || index >= pageContents.count {
            return nil
        }
        // 创建一个新的控制器类，并且分配给相应的数据
        let contentVC = ContentViewController()
        contentVC.content = pageContents[index]
        return contentVC
    }

    func index(of viewController: UIViewController) -> Int? {
        guard let viewController = viewController as? ContentViewController else {
            return nil
        }
        return pageContents.index(of: viewController.content)
    }
}

extension PageController: UIPageViewControllerDataSource {
    func pageViewController(_: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {

        guard let i = index(of: viewController), i != 0 else {
            return nil
        }
        // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
        // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
        // 不用我们去操心每个ViewController的顺序问题

        return controller(at: i - 1)
    }

    func pageViewController(_: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        guard let i = index(of: viewController) else {
            return nil
        }

        if i + 1 == pageContents.count {
            return nil
        }

        return controller(at: i + 1)
    }

    // 配置页指示器总数(只有在水平模式显示)
    func presentationCount(for _: UIPageViewController) -> Int {
        return pageContents.count
    }

    // 当前页指示器索引
    func presentationIndex(for _: UIPageViewController) -> Int {
        return 0
    }
}

extension PageController: UIPageViewControllerDelegate {
    func pageViewController(_: UIPageViewController, willTransitionTo _: [UIViewController]) {
    }

    // 翻页完成,如果翻页过程中取消翻页，则completed＝ false
    func pageViewController(_: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers _: [UIViewController], transitionCompleted completed: Bool) {
        print("finishTransition: finished : \(finished), completed: \(completed)")
    }
}
