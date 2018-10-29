//
//  ViewController.swift
//  Filter
//
//  Created by 伯驹 黄 on 2017/3/1.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit

typealias Filter = (CIImage) -> CIImage
infix operator >>>

func >>>(lter1: @escaping Filter, lter2: @escaping Filter) -> Filter {
    return { image in lter2(lter1(image)) }
}

class ViewController: UIViewController {

    // 模糊
    func blur(radius: Double) -> Filter { return { image in
        let parameters: [String: Any] = [
            kCIInputRadiusKey: radius, kCIInputImageKey: image,
        ]
        guard let lter = CIFilter(name: "CIGaussianBlur",
                                  withInputParameters: parameters)
        else { fatalError() }
        guard let outputImage = lter.outputImage
        else { fatalError() }
        return outputImage
    }
    }

    // 颜色叠层
    func generate(color: UIColor) -> Filter { return { _ in
        let parameters = [kCIInputColorKey: CIColor(cgColor: color.cgColor)]
        guard let lter = CIFilter(name: "CIConstantColorGenerator", withInputParameters: parameters)
        else { fatalError() }
        guard let outputImage = lter.outputImage
        else { fatalError() }
        return outputImage
    }
    }

    // 合成滤镜
    func compositeSourceOver(overlay: CIImage) -> Filter { return { image in
        let parameters = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay,
        ]
        guard let lter = CIFilter(name: "CISourceOverCompositing", withInputParameters: parameters)
        else { fatalError() }
        guard let outputImage = lter.outputImage
        else { fatalError() }
        return outputImage.cropping(to: image.extent)
    }
    }

    // 颜色叠层滤镜
    func overlay(color: UIColor) -> Filter {
        return { image in
            let overlay = self.generate(color: color)(image).cropping(to: image.extent)
            return self.compositeSourceOver(overlay: overlay)(image)
        }
    }

    func compose(lter lter1: @escaping Filter, with lter2: @escaping Filter) -> Filter {
        return { image in lter2(lter1(image)) }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "http://www.objc.io/images/covers/16.jpg")!
        let image = CIImage(contentsOf: url)!
        let radius = 5.0
        let color = UIColor.red.withAlphaComponent(0.2)
        let blurredImage = blur(radius: radius)(image)
        let overlaidImage = overlay(color: color)(blurredImage)

        let result = overlay(color: color)(blur(radius: radius)(image))

        let blurAndOverlay = compose(lter: blur(radius: radius), with: overlay(color: color))
        let result1 = blurAndOverlay(image)

        let blurAndOverlay2 =
            blur(radius: radius) >>> overlay(color: color)
        let result2 = blurAndOverlay2(image)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
