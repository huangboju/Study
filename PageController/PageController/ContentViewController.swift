//
//  ContentViewController.swift
//  PageController
//
//  Created by 伯驹 黄 on 2017/3/9.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    var content = ""

    private lazy var contentLabel: UILabel = {
        let contentLabel = UILabel(frame: CGRect(x: 16, y: 100, width: self.view.frame.width - 32, height: 100))
        contentLabel.numberOfLines = 0
        return contentLabel
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.random
        view.addSubview(contentLabel)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        contentLabel.text = content
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}

extension UIColor {
    static var random: UIColor {
        return UIColor(red: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       green: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       blue: CGFloat(arc4random()) / CGFloat(UInt32.max),
                       alpha: 1.0)
    }
}
