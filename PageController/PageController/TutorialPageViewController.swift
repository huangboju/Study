//
//  TutorialPageViewController.swift
//  PageController
//
//  Created by 伯驹 黄 on 2017/3/10.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

// 可以作为单独控制器使用

class TutorialPageViewController: UIPageViewController {

    weak var tutorialDelegate: TutorialPageViewControllerDelegate?

    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        // The view controllers will be shown in this order
        [
            self.newColoredViewController("Green"),
            self.newColoredViewController("Red"),
            self.newColoredViewController("Blue"),
        ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        if let initialViewController = orderedViewControllers.first {
            scrollToViewController(initialViewController)
        }

        tutorialDelegate?.tutorialPageViewController(self, didUpdatePageCount: orderedViewControllers.count)
    }

    /**
     Scrolls to the next view controller.
     */
    func scrollToNextViewController() {
        if let visibleViewController = viewControllers?.first,
            let nextViewController = pageViewController(self,
                                                        viewControllerAfter: visibleViewController) {
            scrollToViewController(nextViewController)
        }
    }

    /**
     Scrolls to the view controller at the given index. Automatically calculates
     the direction.

     - parameter newIndex: the new index to scroll to
     */
    func scrollToViewController(index newIndex: Int) {
        if let firstViewController = viewControllers?.first,
            let currentIndex = orderedViewControllers.index(of: firstViewController) {
            let direction: UIPageViewControllerNavigationDirection = newIndex >= currentIndex ? .forward : .reverse
            let nextViewController = orderedViewControllers[newIndex]
            scrollToViewController(nextViewController, direction: direction)
        }
    }

    fileprivate func newColoredViewController(_ color: String) -> UIViewController {
        return UIStoryboard(name: "Main", bundle: nil).
            instantiateViewController(withIdentifier: "\(color)ViewController")
    }

    /**
     Scrolls to the given 'viewController' page.

     - parameter viewController: the view controller to show.
     */
    fileprivate func scrollToViewController(_ viewController: UIViewController,
                                            direction: UIPageViewControllerNavigationDirection = .forward) {
        setViewControllers([viewController],
                           direction: direction,
                           animated: true,
                           completion: { (_) -> Void in
                               // Setting the view controller programmatically does not fire
                               // any delegate methods, so we have to manually notify the
                               // 'tutorialDelegate' of the new index.
                               self.notifyTutorialDelegateOfNewIndex()
        })
    }

    /**
     Notifies '_tutorialDelegate' that the current page index was updated.
     */
    fileprivate func notifyTutorialDelegateOfNewIndex() {
        if let firstViewController = viewControllers?.first,
            let index = orderedViewControllers.index(of: firstViewController) {
            tutorialDelegate?.tutorialPageViewController(self,
                                                         didUpdatePageIndex: index)
        }
    }
}

// MARK: UIPageViewControllerDataSource

extension TutorialPageViewController: UIPageViewControllerDataSource {

    func pageViewController(_: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        // User is on the first view controller and swiped left to loop to
        // the last view controller.
        guard previousIndex >= 0 else {
            return orderedViewControllers.last
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.index(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        // User is on the last view controller and swiped right to loop to
        // the first view controller.
        guard orderedViewControllersCount != nextIndex else {
            return orderedViewControllers.first
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }
}

extension TutorialPageViewController: UIPageViewControllerDelegate {

    func pageViewController(_: UIPageViewController,
                            didFinishAnimating _: Bool,
                            previousViewControllers _: [UIViewController],
                            transitionCompleted _: Bool) {
        notifyTutorialDelegateOfNewIndex()
    }
}

protocol TutorialPageViewControllerDelegate: class {

    /**
     Called when the number of pages is updated.

     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter count: the total number of pages.
     */
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageCount count: Int)

    /**
     Called when the current index is updated.

     - parameter tutorialPageViewController: the TutorialPageViewController instance
     - parameter index: the index of the currently visible page.
     */
    func tutorialPageViewController(_ tutorialPageViewController: TutorialPageViewController,
                                    didUpdatePageIndex index: Int)
}
