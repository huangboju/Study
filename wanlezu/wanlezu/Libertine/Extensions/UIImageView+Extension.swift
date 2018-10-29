//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

// import Kingfisher
//
// extension UIImageView {
//    func setImageWithURL(URL: NSURL?, placeholderImage: Image? = nil, optionsInfo: KingfisherOptionsInfo? = nil, progressBlock: DownloadProgressBlock? = nil, completionHandler: CompletionHandler? = nil) -> RetrieveImageTask {
//        return kf_setImageWithURL(URL, placeholderImage: placeholderImage, optionsInfo: optionsInfo, progressBlock: progressBlock, completionHandler: completionHandler)
//    }
//
//    func cutCircleImage() -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(frame.size, false, 0.0)
//        // 获取上下文
//        let ctr = UIGraphicsGetCurrentContext()
//        // 设置圆形
//        let rect = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
//        CGContextAddEllipseInRect(ctr, rect)
//        // 裁剪
//        CGContextClip(ctr)
//        // 将图片画上去
//        setNeedsDisplay()
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
// }
