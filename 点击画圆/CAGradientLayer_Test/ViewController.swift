//
//  ViewController.swift
//  CAGradientLayer_Test
//
//  Created by 伯驹 黄 on 16/4/13.
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let recordingCircleOverlayView = RecordingCircleOverlayView(frame: view.bounds, strokeWidth: 7, insets: UIEdgeInsetsMake(10, 10, 0, 0))

        recordingCircleOverlayView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        recordingCircleOverlayView.duration = 10

        view.addSubview(recordingCircleOverlayView)

        gradientLayer()
    }

    func gradientLayer() {
        let colorLayer = CAGradientLayer()
        colorLayer.backgroundColor = UIColor.yellow.cgColor
        colorLayer.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        colorLayer.position = view.center

        // 颜色分配
        colorLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor, UIColor.green.cgColor]

        // 颜色分割线
        colorLayer.locations = [NSNumber(value: 0.25 as Float), NSNumber(value: 0.5 as Float), NSNumber(value: 0.7 as Float)]

        // 起始点
        colorLayer.startPoint = CGPoint(x: 0, y: 0)

        // 结束点
        colorLayer.endPoint = CGPoint(x: 1, y: 0)
        view.layer.addSublayer(colorLayer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
