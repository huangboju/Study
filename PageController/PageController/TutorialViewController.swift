//
//  TutorialViewController.swift
//  PageController
//
//  Created by 伯驹 黄 on 2017/3/10.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class TutorialViewController: UIViewController {

    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 16, y: 100, width: 100, height: 34))
        pageControl.numberOfPages = 3
        pageControl.backgroundColor = UIColor.lightGray
        return pageControl
    }()

    private lazy var nextButton: UIButton = {
        let nextButton = UIButton(frame: CGRect(x: self.view.frame.width - 120, y: self.view.frame.height - 104, width: 88, height: 44))
        nextButton.setTitle("Next", for: .normal)
        nextButton.alpha = 0.4
        nextButton.backgroundColor = .black
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return nextButton
    }()

    var tutorialPageViewController: TutorialPageViewController? {
        didSet {
            tutorialPageViewController?.tutorialDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.groupTableViewBackground

        pageControl.addTarget(self, action: #selector(TutorialViewController.didChangePageControlValue), for: .valueChanged)

        tutorialPageViewController = TutorialPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        addChildViewController(tutorialPageViewController!)
        tutorialPageViewController!.view.frame = CGRect(x: 0, y: 64, width: view.frame.width, height: view.frame.height - 64)
        view.addSubview(tutorialPageViewController!.view)

        view.addSubview(nextButton)
        view.addSubview(pageControl)
    }

    func didTapNextButton(_: UIButton) {
        tutorialPageViewController?.scrollToNextViewController()
    }

    /**
     Fired when the user taps on the pageControl to change its current page.
     */
    func didChangePageControlValue() {
        tutorialPageViewController?.scrollToViewController(index: pageControl.currentPage)
    }
}

extension TutorialViewController: TutorialPageViewControllerDelegate {

    func tutorialPageViewController(_: TutorialPageViewController,
                                    didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }

    func tutorialPageViewController(_: TutorialPageViewController,
                                    didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}
