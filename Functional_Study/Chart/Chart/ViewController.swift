//
//  ViewController.swift
//  Chart
//
//  Created by 伯驹 黄 on 2017/3/14.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var blurBackView: UIView = {
        let blurBackView = UIView()
        blurBackView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 64)
        gradientLayer.colors = [
            UIColor(hex: 0x040012 , alpha: 0.76).cgColor,
            UIColor(hex: 0x040012, alpha: 0.28).cgColor
        ]
        gradientLayer.startPoint = .zero
        gradientLayer.endPoint = CGPoint(x: 0, y: 1.0)
        blurBackView.layer.addSublayer(gradientLayer)
        blurBackView.isUserInteractionEnabled = false
        blurBackView.alpha = 0.5
        return blurBackView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        let tool = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 64))
        tool.barStyle = .black

        view.addSubview(tool)

        view.addSubview(blurBackView)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 140, width: 300, height: 200))
        imageView.image = draw()
        view.addSubview(imageView)
    }

    func draw() -> UIImage {
        let bounds = CGRect(origin: .zero, size: CGSize(width: 300, height: 200))
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { context in
            let blueSquare = square(side: 1).filled(.blue)
            let redSquare = square(side: 2).filled(.red)
            let greenCircle = circle(diameter:1).filled(.green)
            let cyanCircle = circle(diameter:1).filled(.cyan)
            let example2 = blueSquare ||| cyanCircle ||| redSquare ||| greenCircle
            context.cgContext.draw(example2, in: bounds)

//            let contents: [(String, Double)] = [
//                ("Moscow", 11.2),
//                ("Shanghai", 10),
//                ("Istanbul", 11),
//                ("Berlin", 8),
//                ("New York", 4)
//            ]
//
//            context.cgContext.draw(barGraph(contents), in: bounds)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


indirect enum Diagram {
    case primitive(CGSize, Primitive)
    case beside(Diagram, Diagram)
    case below(Diagram, Diagram)
    case attributed(Attribute, Diagram)
    case align(CGPoint, Diagram)
}

enum Primitive {
    case ellipse
    case rectangle
    case text(String)
}

enum Attribute {
    case fillColor(UIColor)
}

extension Diagram {
    var size: CGSize {
        switch self {
        case .primitive(let size, _):
            return size
        case .attributed(_, let x):
            return x.size
        case let .beside(l, r):
            let sizeL = l.size
            let sizeR = r.size
            return CGSize(width: sizeL.width + sizeR.width, height: max(sizeL.height, sizeR.height))
        case let .below(l, r):
            return CGSize(width: max(l.size.width, r.size.width), height: l.size.height + r.size.height)
        case.align(_, let r):
            return r.size
        }
    }
}



func *(l: CGFloat, r: CGSize) -> CGSize{
    return CGSize(width: l * r.width, height: l * r.height)
}

func *(l: CGSize, r: CGSize) -> CGSize{
    return CGSize(width: l.width * r.width, height: l.height * r.height)
}

func -( l : CGSize, r: CGSize) -> CGSize {
    return CGSize(width:l.width - r.width,height: l.height - r.height)
}

func +(l: CGPoint, r: CGPoint) -> CGPoint {
    return CGPoint(x: l.x + r.x, y: l.y + r.y)
}


extension CGContext {
    func draw(_ primitive: Primitive, in frame: CGRect) {
        switch primitive {
        case .rectangle:
            fill(frame)
        case .ellipse :
            fillEllipse(in: frame)
        case .text(let text):
            let font = UIFont.systemFont(ofSize: 12)
            let attributes = [NSFontAttributeName: font]
            let attributedText = NSAttributedString(string: text, attributes: attributes)
            attributedText.draw(in: frame)
        }
    }

    func draw(_ diagram: Diagram, in bounds: CGRect) {
        switch diagram {
        case let .primitive(size, primitive):
            let bounds = size.fit(into: bounds, alignment: .center)
            draw(primitive, in: bounds)
        case .align(let alignment, let diagram):
            let bounds = diagram.size.fit(into: bounds, alignment: alignment)
            draw(diagram, in: bounds)
        case let .beside(left, right):
            let (lBounds, rBounds) = bounds.split(
                ratio: left.size.width/diagram.size.width,edge:.minXEdge)
            draw(left, in: lBounds)
            draw(right, in: rBounds)
        case let .below(top, bottom):
            let (tBounds, bBounds) = bounds.split(
                ratio: top.size.height / diagram.size.height, edge: .minYEdge)
            draw(top, in: tBounds)
            draw(bottom, in: bBounds)
        case let .attributed(.fillColor(color), diagram):
            saveGState()
            color.set()
            draw(diagram, in: bounds)
            restoreGState()
        }
    }
}

func barGraph(_ input: [(String, Double)]) -> Diagram {
    let values: [CGFloat] = input.map { CGFloat($0.1) }
    let bars = values.normalized.map { x in
        return rect(width: 1, height: 3 * x).filled(.black).aligned(to: .bottom) }.hcat
    let labels = input.map { label, _ in
        return text(label, width: 1, height: 0.3).aligned(to: .top)
        }.hcat
    return bars --- labels
}


func rect(width: CGFloat, height: CGFloat) -> Diagram {
    return .primitive(CGSize(width: width, height: height), .rectangle)
}

func circle(diameter: CGFloat) -> Diagram {
    return .primitive(CGSize(width: diameter, height: diameter), .ellipse)
}

func text(_ theText: String, width: CGFloat, height: CGFloat) -> Diagram {
    return .primitive(CGSize(width: width, height: height), .text(theText))
}

func square(side: CGFloat) -> Diagram {
    return rect(width: side, height: side)
}

precedencegroup HorizontalCombination {
    higherThan: VerticalCombination
    associativity: left
}


// MARK: - operator

infix operator |||: HorizontalCombination
func |||(l: Diagram, r: Diagram) -> Diagram {
    return .beside(l, r)
}
precedencegroup VerticalCombination {
    associativity: left
}

infix operator ---: VerticalCombination
func ---(l: Diagram, r: Diagram)-> Diagram {
    return .below(l, r)
}

extension Diagram {
    func filled(_ color: UIColor) -> Diagram {
        return .attributed(.fillColor(color), self)
    }

    func aligned(to position: CGPoint) -> Diagram {
        return .align(position, self)
    }

    init () {
        self = rect(width: 0, height: 0)
    }
}

// MARK: - Extension

extension CGPoint {
    var size: CGSize { return CGSize(width: x, height: y) }
}

extension CGSize {
    var point: CGPoint {
        return CGPoint(x: width, y: height)
    }
    
    func fit(into rect: CGRect, alignment: CGPoint) -> CGRect {
        let scale = min(rect.width / width, rect.height / height)
        let targetSize = scale * self
        let spacerSize = alignment.size * (rect.size - targetSize)
        return CGRect(origin: rect.origin + spacerSize.point, size: targetSize)
    }
}

extension CGRectEdge {
    var isHorizontal: Bool {
        return self == .maxXEdge || self == .minXEdge
    }
}

extension CGRect {
    func split(ratio: CGFloat, edge: CGRectEdge)-> (CGRect, CGRect) {
        let length = edge.isHorizontal ? width : height
        return divided(atDistance: length * ratio, from: edge)
    }
}

extension CGPoint {
    static let bottom = CGPoint(x: 0.5, y: 1)
    static let top = CGPoint(x: 0.5, y: 1)
    static let center = CGPoint(x: 0.5, y: 0.5)
}

extension Sequence where Iterator.Element == CGFloat {
    var normalized: [CGFloat] {
        let maxVal = reduce(0){ Swift.max($0, $1) }
        return map{ $0 / maxVal }
    }
}

extension Sequence where Iterator.Element == Diagram {
    var hcat: Diagram {
        return reduce(Diagram(), |||)
    }
}

extension UIImage {
    func my_Image(with size: CGSize, fillColor: UIColor, cornerRadio: CGFloat, completion: @escaping ((UIImage) -> Void)) {
        DispatchQueue.global().async {
            UIGraphicsBeginImageContextWithOptions(size, true, 0)
            let aspectFitSize = size
            let rect = CGRect(x: 0, y: 0, width: aspectFitSize.width+0.3, height: aspectFitSize.height+0.3)
            fillColor.setFill()
            UIRectFill(rect)
            if cornerRadio != 0 {
                let path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: aspectFitSize), byRoundingCorners: .allCorners, cornerRadii: CGSize(width: 10, height: 10))
                path.addClip()
            }
            self.draw(in: rect)
            let result = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            DispatchQueue.main.async {
                completion(result ?? self)
            }
        }
    }
}

extension UIColor {
    /** 16进制颜色 */
    convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0xFF00) >> 8) / 255
        let blue = CGFloat(hex & 0xFF) / 255
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
