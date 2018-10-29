//
//  AccountHeaderView.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/15.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

class AccountHeaderView: UIView {

    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.textColor = UIColor(hex: 0x666666)
        textLabel.textAlignment = .center
        textLabel.font = UIFontMake(30)
        return textLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: Constants.bigRowHeight)
        textLabel.frame = self.frame.insetBy(dx: PADDING, dy: PADDING)

        addSubview(textLabel)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
