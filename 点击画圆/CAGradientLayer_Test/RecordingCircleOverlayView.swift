//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class RecordingCircleOverlayView: UIView, CAAnimationDelegate {
    var duration: CGFloat = 45

    fileprivate var progressLayers = [CAShapeLayer]()
    fileprivate var circlePath: UIBezierPath?
    fileprivate var currentProgressLayer = CAShapeLayer()
    fileprivate let backgroundLayer = CAShapeLayer()
    fileprivate var strokeWidth: CGFloat?
    fileprivate var circleComplete = false

    init(frame: CGRect, strokeWidth: CGFloat, insets: UIEdgeInsets) {
        super.init(frame: frame)

        self.strokeWidth = strokeWidth
        let arcCenter = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.midX - insets.top - insets.bottom

        circlePath = UIBezierPath(arcCenter: arcCenter, radius: radius, startAngle: CGFloat.pi, endAngle: -CGFloat.pi, clockwise: false)

        addBackgroundLayer()
    }

    fileprivate func addBackgroundLayer() {
        backgroundLayer.path = circlePath?.cgPath
        backgroundLayer.strokeColor = UIColor.lightGray.cgColor
        backgroundLayer.fillColor = nil
        backgroundLayer.lineWidth = strokeWidth!

        layer.addSublayer(backgroundLayer)
    }

    fileprivate func addNewLayer() {
        let progressLayer = CAShapeLayer()
        progressLayer.path = circlePath?.cgPath
        progressLayer.strokeColor = randomColor().cgColor
        progressLayer.fillColor = nil
        progressLayer.lineWidth = strokeWidth!
        progressLayer.strokeEnd = 0

        layer.addSublayer(progressLayer)
        progressLayers.append(progressLayer)

        currentProgressLayer = progressLayer
    }

    fileprivate func randomColor() -> UIColor {
        let hue = (CGFloat(arc4random() % 256) / 256.0) //  0.0 to 1.0
        let saturation = (CGFloat(arc4random() % 128) / 256.0) + 0.5 //  0.5 to 1.0, away from white
        let brightness = (CGFloat(arc4random() % 128) / 256.0) + 0.5 //  0.5 to 1.0, away from black
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
    }

    fileprivate func updateAnimations() {
        let duration = self.duration * (1 - (progressLayers.first?.strokeEnd)!)
        var strokeEndFinal: CGFloat = 1

        for progressLayer in progressLayers {
            let strokeEndAnimation = self.strokeEndAnimation(duration, fromValue: progressLayer.strokeEnd, toValue: strokeEndFinal)

            let previousStrokeEnd = progressLayer.strokeEnd

            progressLayer.strokeEnd = strokeEndFinal

            progressLayer.add(strokeEndAnimation, forKey: "strokeEndAnimation")

            strokeEndFinal -= (previousStrokeEnd - progressLayer.strokeStart)

            if progressLayer != currentProgressLayer {
                let strokeStartAnimation = self.strokeStartAnimation(duration, fromValue: progressLayer.strokeStart, toValue: strokeEndFinal)

                progressLayer.strokeStart = strokeEndFinal

                progressLayer.add(strokeStartAnimation, forKey: "strokeStartAnimation")
            }

            let backgroundLayerAnimation = strokeStartAnimation(duration, fromValue: backgroundLayer.strokeStart, toValue: 1)
            backgroundLayerAnimation.delegate = self
            backgroundLayer.strokeStart = 1.0
            backgroundLayer.add(backgroundLayerAnimation, forKey: "strokeStartAnimation")
        }
    }

    fileprivate func updateLayerModelsForPresentationState() {
        for progressLayer in progressLayers {
            progressLayer.strokeStart = (progressLayer.presentation()?.strokeStart)!
            progressLayer.strokeEnd = (progressLayer.presentation()?.strokeEnd)!
            progressLayer.removeAllAnimations()
        }

        backgroundLayer.strokeStart = (backgroundLayer.presentation()?.strokeStart)!

        backgroundLayer.removeAllAnimations()
    }

    // MARK: - UIResponder overrides

    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        if circleComplete == false {
            addNewLayer()
            updateAnimations()
        }
    }

    override func touchesEnded(_: Set<UITouch>, with _: UIEvent?) {
        if circleComplete == false {
            updateLayerModelsForPresentationState()
        }
    }

    // MARK: - CAAnimation Delegate
    func animationDidStop(_: CAAnimation, finished flag: Bool) {
        if circleComplete == false && flag {
            circleComplete = flag
        }
    }

    fileprivate func strokeStartAnimation(_ duration: CGFloat, fromValue: Any, toValue: Any) -> CABasicAnimation {
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
        strokeStartAnimation.duration = TimeInterval(duration)
        strokeStartAnimation.fromValue = fromValue
        strokeStartAnimation.toValue = toValue
        strokeStartAnimation.autoreverses = false
        strokeStartAnimation.repeatCount = 0

        return strokeStartAnimation
    }

    fileprivate func strokeEndAnimation(_ duration: CGFloat, fromValue: Any, toValue: Any) -> CABasicAnimation {
        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeStartAnimation.duration = TimeInterval(duration)
        strokeStartAnimation.fromValue = fromValue
        strokeStartAnimation.toValue = toValue
        strokeStartAnimation.autoreverses = false
        strokeStartAnimation.repeatCount = 0

        return strokeStartAnimation
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
