//
//  UIImage+Extension.swift
//  Chart
//
//  Created by 伯驹 黄 on 2017/3/14.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import UIKit
import Accelerate

extension UIImage {

    func applyLightEffect(withRadius blurRadius: CGFloat = 60) -> UIImage? {
        let tintColor = UIColor(white: 1.0, alpha: 0.3)
        return applyBlur(withRadius: blurRadius, tinted: tintColor, saturationDeltaFactor: 1.8)
    }

    func applyExtraLightEffect(withRadius blurRadius: CGFloat = 40) -> UIImage? {
        let tintColor = UIColor(white: 0.97, alpha: 0.82)
        return applyBlur(withRadius: blurRadius, tinted: tintColor, saturationDeltaFactor: 1.8)
    }

    func applyDarkEffect(withRadius blurRadius: CGFloat = 40) -> UIImage? {
        let tintColor = UIColor(white: 0.11, alpha: 0.73)
        return applyBlur(withRadius: blurRadius, tinted: tintColor, saturationDeltaFactor: 1.8)
    }

    func applyTintEffect(with tintColor: UIColor, blurRadius: CGFloat = 20) -> UIImage? {
        let effectColorAlpha: CGFloat = 0.6
        var effectColor = tintColor
        let components = tintColor.cgColor.numberOfComponents
        if components == 2 {
            var white: CGFloat = 0
            if tintColor.getWhite(&white, alpha: nil) {
                effectColor = UIColor(white: white, alpha: effectColorAlpha)
            }
        } else {
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
            if tintColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {
                effectColor = UIColor(red: red, green: green, blue: blue, alpha: effectColorAlpha)
            }
        }
        return applyBlur(withRadius: blurRadius, tinted: effectColor, saturationDeltaFactor: -1.0)
    }

    func applyBlur(withRadius blurRadius: CGFloat, tinted tintColor: UIColor? = nil, saturationDeltaFactor: CGFloat, maskedIn maskImage: UIImage? = nil) -> UIImage? {
        if size.height < 1 || size.width < 1 {
            print("*** error: invalid size: (\(self.size.width), \(self.size.height). Both dimensions must be >= 1: \(self))")
            return nil
        }

        if cgImage == nil {
            print("*** error: the image must be backed by a cgImage: \(self)")
            return nil
        }

        if let image = maskImage, maskImage?.cgImage == nil {
            print("*** error: the maskedImage must be backed by a cgImage: \(image)")
            return nil
        }

        let floatEpsilon: CGFloat = 1.19209290e-7
        let hasBlur = blurRadius > floatEpsilon
        let hasSaturationChange = fabs(saturationDeltaFactor - 1) > floatEpsilon

        let imageRect = CGRect(origin: .zero, size: self.size)
        let renderer = UIGraphicsImageRenderer(size: self.size)
        return renderer.image { imageContext in

            let context = imageContext.cgContext
            context.scaleBy(x: 1, y: -1)
            context.translateBy(x: 0, y: -self.size.height)

            if hasBlur || hasSaturationChange {
                var effectInBuffer: vImage_Buffer = vImage_Buffer(), scratchBuffer1: vImage_Buffer = vImage_Buffer()
                var inputBuffer: vImage_Buffer, outputBuffer: vImage_Buffer

                var format = vImage_CGImageFormat(bitsPerComponent: 8, bitsPerPixel: 32, colorSpace: nil, bitmapInfo: [.byteOrder32Little, CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedFirst.rawValue)], version: 0, decode: nil, renderingIntent: .defaultIntent)
                let error = vImageBuffer_InitWithCGImage(&effectInBuffer, &format, nil, self.cgImage!, vImage_Flags(kvImagePrintDiagnosticsToConsole))

                if error != kvImageNoError {
                    print("*** error: vImageBuffer_InitWithCGImage returned error code \(error) for \(self)")
                    return
                }
                vImageBuffer_Init(&scratchBuffer1, effectInBuffer.height, effectInBuffer.width, format.bitsPerPixel, vImage_Flags(kvImageNoFlags))
                inputBuffer = effectInBuffer
                outputBuffer = scratchBuffer1

                if hasBlur {
                    let inputRadius = (blurRadius * self.scale) - 2 < floatEpsilon ? 2 : (blurRadius * self.scale)
                    let floatRadius: CGFloat = floor((inputRadius * 3 * sqrt(CGFloat.pi * 2) / 4 + 0.5) / 2)
                    var radius = UInt32(floatRadius)
                    radius |= 1

                    let tempBufferSize = vImageBoxConvolve_ARGB8888(&inputBuffer, &outputBuffer, nil, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend) | vImage_Flags(kvImageGetTempBufferSize))
                    let tempBuffer = malloc(tempBufferSize)
                    vImageBoxConvolve_ARGB8888(&inputBuffer, &outputBuffer, tempBuffer, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
                    vImageBoxConvolve_ARGB8888(&outputBuffer, &inputBuffer, tempBuffer, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
                    vImageBoxConvolve_ARGB8888(&inputBuffer, &outputBuffer, tempBuffer, 0, 0, radius, radius, nil, vImage_Flags(kvImageEdgeExtend))
                    swap(&inputBuffer, &outputBuffer)
                }

                if hasSaturationChange {
                    let s = saturationDeltaFactor
                    let floatingPointSaturationMatrix: [CGFloat] = [
                        0.0722 + 0.9278 * s, 0.0722 - 0.0722 * s, 0.0722 - 0.0722 * s, 0,
                        0.7152 - 0.7152 * s, 0.7152 + 0.2848 * s, 0.7152 - 0.7152 * s, 0,
                        0.2126 - 0.2126 * s, 0.2126 - 0.2126 * s, 0.2126 + 0.7873 * s, 0,
                        0, 0, 0, 1,
                    ]
                    let divisor: Int32 = 256
                    let saturationMatrix = floatingPointSaturationMatrix.map { Int16(roundf(Float($0) * Float(divisor))) }
                    vImageMatrixMultiply_ARGB8888(&inputBuffer, &outputBuffer, saturationMatrix, divisor, nil, nil, vImage_Flags(kvImageNoFlags))
                }

                var effectCGImage = vImageCreateCGImageFromBuffer(&inputBuffer, &format, nil, nil, vImage_Flags(kvImageNoAllocate), nil)

                if effectCGImage == nil {
                    effectCGImage = vImageCreateCGImageFromBuffer(&inputBuffer, &format, nil, nil, vImage_Flags(kvImageNoFlags), nil)
                    free(&inputBuffer)
                }

                if maskImage != nil {
                    context.draw(self.cgImage!, in: imageRect)
                }

                context.saveGState()
                if let maskImage = maskImage {
                    context.clip(to: imageRect, mask: maskImage.cgImage!)
                }

                context.draw(effectCGImage!.takeUnretainedValue(), in: imageRect)

                context.restoreGState()
            } else {
                context.draw(self.cgImage!, in: imageRect)
            }

            if let tintColor = tintColor {
                context.saveGState()
                context.setFillColor(tintColor.cgColor)
                context.fill(imageRect)
                context.restoreGState()
            }
        }
    }
}
