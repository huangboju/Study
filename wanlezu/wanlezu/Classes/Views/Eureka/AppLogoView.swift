//
//  AppLogoView.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/15.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

class AppLogoView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.red
        self.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: Constants.bigRowHeight)
        imageView.frame = self.frame.insetBy(dx: PADDING, dy: PADDING)
        imageView.autoresizingMask = .flexibleWidth

        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
