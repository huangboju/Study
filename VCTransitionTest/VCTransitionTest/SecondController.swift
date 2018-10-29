//
//  SecondController.swift
//  VCTransitionTest
//
//  Created by 伯驹 黄 on 2016/10/28.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class SecondController: UIViewController {

    private lazy var dismissButton: UIButton = {
        let dismissButton = UIButton(frame: CGRect(x: 44, y: 100, width: 44, height: 44))
        dismissButton.backgroundColor = UIColor.red
        dismissButton.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return dismissButton
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        view.addSubview(dismissButton)
    }

    func dismissAction() {
        dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
