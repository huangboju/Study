//
//  ViewController.swift
//  KeyframesAnimation
//
//  Created by 伯驹 黄 on 2016/10/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "tom6"))
        imageView.backgroundColor = UIColor.white
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
    }

    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        changeBackground()
    }

    func changeBackground() {
        let duration: Double = 1 / 4
        UIView.animateKeyframes(withDuration: 9, delay: 0, options: .calculationModeLinear, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                self.imageView.backgroundColor = UIColor(red: 0.9475, green: 0.1921, blue: 0.1746, alpha: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: duration, relativeDuration: duration, animations: {
                self.imageView.backgroundColor = UIColor(red: 0.1064, green: 0.6052, blue: 0.0334, alpha: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 2 * duration, relativeDuration: duration, animations: {
                self.imageView.backgroundColor = UIColor(red: 0.1366, green: 0.3017, blue: 0.8411, alpha: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 3 * duration, relativeDuration: duration, animations: {
                self.imageView.backgroundColor = UIColor(red: 0.619, green: 0.037, blue: 0.6719, alpha: 1)
            })
            UIView.addKeyframe(withRelativeStartTime: 3 * duration, relativeDuration: duration, animations: {
                self.imageView.backgroundColor = UIColor.white
            })
        }) { _ in
            print("over")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
