//
//  ViewController.swift
//  HZADAlert
//
//  Created by 黄伯驹 on 2017/10/31.
//  Copyright © 2017年 黄伯驹. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let button = UIButton()
    let dimmingView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editAction))

//        drawCircle()
//        drawRectangle()
//        drawChartView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
    }

    func showADController() {
        let controller = ADController(str: "")
        present(controller, animated: true, completion: nil)
    }

    @objc func editAction() {

        let adAlert = ADAlert(url: "https://www.google.ca/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png")
        adAlert.intervalDate = .second(5)
        adAlert.show()

//        let w = UIScreen.main.bounds.width
//        let h = UIScreen.main.bounds.height
//
//        dimmingView.frame = CGRect(x: 0, y: 0, width: w, height: h)
//
//        UIApplication.shared.keyWindow?.addSubview(dimmingView)
//
//        let contentView = UIView(frame: CGRect(x: 28, y: -416, width: w - 56, height: 416))
//        contentView.backgroundColor = .red
//        dimmingView.addSubview(contentView)
//
//
//        UIView.animate(withDuration: 0.4, animations: {
//            contentView.frame.origin.y = 95
//            self.dimmingView.backgroundColor = UIColor(white: 0, alpha: 0.5)
//            self.drawCloseButton(with: contentView.frame.maxY)
//        })
    }

    func drawCloseButton(with y: CGFloat) {

        let buttonSize = CGSize(width: 22, height: 22)
        let x = view.center.x
        let lineHight: CGFloat = 75
        let radius = buttonSize.width + 5

        button.setImage(UIImage(named: "ic_btn_close")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = .white
        button.alpha = 0
        button.frame.size = buttonSize
        button.center = CGPoint(x: x, y: lineHight + radius + y)
        var applyTransform = CGAffineTransform(rotationAngle: -3 * .pi)
        applyTransform = applyTransform.scaledBy(x: 0.1, y: 0.1)
        button.transform = applyTransform


        dimmingView.addSubview(button)

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
        dimmingView.layer.addSublayer(lineLayer2)
    }

    func drawCircle() {
        let circlePath = UIBezierPath(arcCenter: CGPoint(x: 100, y: 200), radius: 50, startAngle: -0.5 * .pi, endAngle:  1.5 * .pi, clockwise: true)
        
        circlePath.move(to: CGPoint(x: 60, y: 170))
        circlePath.addLine(to: CGPoint(x: 140, y: 170))
        circlePath.move(to: CGPoint(x: 60, y: 230))
        circlePath.addLine(to: CGPoint(x: 140, y: 230))
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.lineWidth = 2
        shapeLayer.path = circlePath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.black.cgColor
        shapeLayer.add(endAnimation(), forKey: nil)
        view.layer.addSublayer(shapeLayer)
    }
    
    func drawRectangle() {
        let path = UIBezierPath(rect: CGRect(x: 110, y: 100, width: 150, height: 100))
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.black.cgColor
        layer.add(endAnimation(), forKey: nil)
        view.layer.addSublayer(layer)
    }

    func drawChartView() {
        let bezierPath = UIBezierPath(roundedRect: CGRect(x: 10, y: 400, width: view.frame.width - 20, height: 100), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10))
        
        bezierPath.move(to: CGPoint(x: 100, y: 360))
        bezierPath.addLine(to: CGPoint(x: 80, y: 400))
        bezierPath.addLine(to: CGPoint(x: 120, y: 400))
        bezierPath.addLine(to: CGPoint(x: 100, y: 360))
        
        let shaperLayer1 = CAShapeLayer()
        shaperLayer1.strokeColor = UIColor.orange.cgColor
        shaperLayer1.fillColor = UIColor.clear.cgColor
        view.layer.addSublayer(shaperLayer1)
        shaperLayer1.path = bezierPath.cgPath
        shaperLayer1.add(endAnimation(), forKey: nil)
    }

    func startAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeStart")
        animation.fromValue = NSNumber(value: 0)
        animation.toValue = NSNumber(value: 1)
        animation.duration = 1
        animation.isRemovedOnCompletion = true
        return animation
    }

    func endAnimation() -> CABasicAnimation {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = NSNumber(value: -1)
        animation.toValue = NSNumber(value: 1)
        animation.duration = 1
        animation.isRemovedOnCompletion = true
        return animation
    }
}

extension ViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {

        UIView.animate(withDuration: 0.4) {
            self.button.alpha = 1
            self.button.transform = .identity
        }
    }
}

