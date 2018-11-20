//
//  CoreImage.swift
//  Functional
//
//  Created by 伯驹 黄 on 2017/3/23.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import CoreImage

typealias Filter = (CIImage) -> CIImage

func blur(radius: Double) -> Filter {
    return { image in
        let parameters: [String: Any] = [kCIInputRadiusKey: radius, kCIInputImageKey: image]
        guard let  lter = CIFilter(name: "CIGaussianBlur",
                                    withInputParameters: parameters) else { fatalError () }
        guard let outputImage =  lter.outputImage else { fatalError () }
        return outputImage
    }
}

func generate(color: UIColor) -> Filter {
    return { _ in
        let parameters = [kCIInputColorKey: CIColor(cgColor: color.cgColor)]
        guard let  lter = CIFilter (name: "CIConstantColorGenerator", withInputParameters: parameters) else { fatalError () }
        guard let outputImage =  filter.outputImage else { fatalError () }
        return outputImage
    }
}

func compositeSourceOver(overlay: CIImage) -> Filter {
    return { image in
        let parameters = [
            kCIInputBackgroundImageKey: image,
            kCIInputImageKey: overlay
        ]
        guard let filter = CIFilter(name: "CISourceOverCompositing",
                                    withInputParameters: parameters) else { fatalError () }
        guard let outputImage = filter.outputImage else { fatalError () }
        return outputImage.cropping(to: image.extent)
    }
}

func overlay(color: UIColor) -> Filter {
    return { image in
        let overlay = generate(color: color)(image).cropping(to: image.extent)
        return compositeSourceOver(overlay: overlay)(image)
    }
}


infix operator>>>
func >>>(filter1: @escaping Filter, filter2: @escaping Filter) -> Filter {
    return { image in filter2(filter1(image)) }
}
