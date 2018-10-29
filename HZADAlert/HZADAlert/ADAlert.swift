//
//  ADAlert.swift
//  HZADAlert
//
//  Created by 黄伯驹 on 2017/11/1.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit
import Kingfisher

enum IntervalDate {
    case second(Double) // 主要用于调试
    case day(Double)
    case hour(Double)
    case week(Double)

    var timeInterval: TimeInterval {
        let f = curry(3600)
        switch self {
        case let .second(s):
            return s
        case let .hour(h):
            return f(h)
        case let .day(d):
            return f(d * 24)
        case let .week(w):
            return f(7 * 24 * w)
        }
    }

    private func curry(_ n: Double) -> (Double) -> Double {
        return { $0 * n }
    }
}

class ADAlert: UIView {

    // 高宽比
    public var scale: CGFloat = 416 / 317 {
        didSet {
            setContetViewSize()
        }
    }

    public var intervalDate: IntervalDate = .day(1)

    // 左边边距
    public var margin: CGFloat = 28 {
        didSet {
            setContetViewSize()
        }
    }

    // 图片圆角
    public var imageViewCornerRadius: CGFloat = 10 {
        didSet {
            setContetViewCorner()
        }
    }

    public var closeHandle: (() -> Void)?

    public var reviewHandle: (() -> Void)?
    
    private lazy var closeBtn: UIButton = {

        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: 24, height: 24)))
        button.setImage(UIImage(named: "ic_btn_close"), for: .normal)
        button.alpha = 0
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)

        var applyTransform = CGAffineTransform(rotationAngle: -3 * .pi)
        applyTransform = applyTransform.scaledBy(x: 0.1, y: 0.1)
        button.transform = applyTransform
        return button
    }()

    private lazy var contentView: UIButton = {
        let contentView = UIButton()
        contentView.imageView?.contentMode = .scaleAspectFit
        contentView.backgroundColor = .white
        contentView.addTarget(self, action: #selector(reviewAD), for: .touchUpInside)
        return contentView
    }()

    private var url: String!

    convenience init(url: String) {
        let ScreenBounds = UIScreen.main.bounds
        self.init(frame: CGRect(origin: .zero, size: ScreenBounds.size))

        self.url = url

        addSubview(contentView)

        addSubview(closeBtn)

        setContetViewSize()
        setContetViewCorner()
    }
    
    private func setContetViewSize() {
        let w = frame.width - margin * 2
        contentView.frame = CGRect(x: margin, y: 0, width: w, height: w * scale)
    }
    
    private func setContetViewCorner() {
        contentView.layer.cornerRadius = imageViewCornerRadius
        contentView.clipsToBounds = true
    }

    public func show() {

        guard isCanShow else { return }

        contentView.kf.setImage(with: URL(string: url), for: .normal) { (image, error, type, url) in

            if error != nil {
                print("❌❌❌ 图片出错")
                return
            }
            if self.superview == nil {
                UIApplication.shared.keyWindow?.addSubview(self)
            }

            UIView.animate(withDuration: 0.4, animations: {
                self.contentView.frame.origin.y = 95
                self.backgroundColor = UIColor(white: 0, alpha: 0.5)
                self.drawCloseButton(with: self.contentView.frame.maxY)
            })
        }
    }

    private var isCanShow: Bool {
        
        let defaults = UserDefaults.standard
        // 链接更新
        if defaults.string(forKey: "ad_url") != url {
             defaults.set(url, forKey: "ad_url")
            return true
        }

        // 没有存过时间，代表没有显示过
        guard let showedDate = defaults.object(forKey: "showed_date") as? Date else {
            defaults.set(Date(), forKey: "showed_date")
            return true
        }

        // 间隔时间没到
        if -showedDate.timeIntervalSinceNow < intervalDate.timeInterval {
            print("⚠️ 广告间隔时间没到")
            return false
        }

        return true
    }

    private func drawCloseButton(with y: CGFloat) {

        let x = center.x
        let lineHight: CGFloat = 75
        let radius: CGFloat = 12

        
        closeBtn.center = CGPoint(x: x, y: lineHight + radius + y)

        let firstPath = UIBezierPath()
        let p1 = CGPoint(x: 0, y: 0)
        let p2 = CGPoint(x: 0, y: lineHight)
        firstPath.move(to: p1)
        firstPath.addLine(to: p2)

        firstPath.addArc(withCenter: CGPoint(x: 0, y: lineHight + radius), radius: radius, startAngle: -0.5 * .pi, endAngle: 1.5 * .pi, clockwise: true)

        let lineLayer2 = CAShapeLayer()
        lineLayer2.frame = CGRect(x: x, y: y, width: 320, height: 40)

        lineLayer2.fillColor = UIColor.clear.cgColor
        lineLayer2.path = firstPath.cgPath
        lineLayer2.strokeColor = UIColor.white.cgColor

        let animat = endAnimation()
        animat.delegate = self
        lineLayer2.add(animat, forKey: "close_btn_animaiton")
        layer.addSublayer(lineLayer2)
    }

    private func endAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = -1
        animation.toValue = 1
        animation.duration = 1
        animation.isRemovedOnCompletion = true
        return animation
    }

    private func clearLayersAndViews() {
        // 存储显示时间
        UserDefaults.standard.set(Date(), forKey: "showed_date")

        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundColor = .clear
            self.subviews.forEach { $0.removeFromSuperview() }
            self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }

    // MARK: - Actions
    @objc
    private func closeAction() {
        closeHandle?()

        clearLayersAndViews()
    }

    @objc
    private func reviewAD() {
        reviewHandle?()

        clearLayersAndViews()
    }
}

extension ADAlert: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        UIView.animate(withDuration: 0.4) {
            self.closeBtn.alpha = 1
            self.closeBtn.transform = .identity
        }
    }
}
