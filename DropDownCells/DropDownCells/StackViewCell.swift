//
//  StackViewCell.swift
//  DropDownCells
//
//  Created by 黄伯驹 on 2017/7/14.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class StackViewCell: UITableViewCell {
    
    @IBOutlet weak var openView: UIView!
    
    
    @IBOutlet weak var stuffView: UIView! {
        didSet {
            stuffView?.isHidden = true
            stuffView?.alpha = 0
        }
    }

    @IBOutlet weak var open: UIButton!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var salary: UILabel!

    @IBOutlet weak var textView: UITextView!

    var cellExists = false

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor(r: 50, g: 54, b: 64)
    }

    func animate(duration: Double, c: @escaping () -> Void) {
        UIView.animateKeyframes(withDuration: duration, delay: 0, options: .calculationModePaced, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: duration, animations: {
                self.stuffView.isHidden = !self.stuffView.isHidden
                if self.stuffView.alpha == 1 {
                    self.stuffView.alpha = 0.5
                } else {
                    self.stuffView.alpha = 1
                }
            })
        }, completion: {  (finished: Bool) in
            print("animation complete")
            c()
        })
    }
}
