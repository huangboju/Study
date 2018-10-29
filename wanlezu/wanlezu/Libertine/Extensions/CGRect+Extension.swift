//
//  CGRect.swift
//  Libertine
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

extension CGRect {

    /// 获取rect的center，包括rect本身的x/y偏移
    var center: CGPoint {
        return CGPoint(x: flat(midX), y: flat(midY))
    }

    /// 对CGRect的x/y、width/height都调用一次flat，以保证像素对齐
    var flatted: CGRect {
        return CGRect(x: flat(minX), y: flat(minY), width: flat(width), height: flat(height))
    }

    /// 为一个CGRect叠加scale计算
    func apply(scale: CGFloat) -> CGRect {
        return CGRect(x: minX * scale, y: minY * scale, width: width * scale, height: height * scale).flatted
    }

    /// 计算view的水平居中，传入父view和子view的frame，返回子view在水平居中时的x值
    func minXHorizontallyCenter(in parentRect: CGRect) -> CGFloat {
        return flat((parentRect.width - width) / 2.0)
    }

    /// 计算view的垂直居中，传入父view和子view的frame，返回子view在垂直居中时的y值
    func minYVerticallyCenter(in parentRect: CGRect) -> CGFloat {
        return flat((parentRect.height - height) / 2.0)
    }

    /// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持垂直居中时，layoutingRect的originY
    func minYVerticallyCenter(layoutingRect: CGRect) -> CGFloat {
        return minY + minYVerticallyCenter(in: layoutingRect)
    }

    /// 返回值：同一个坐标系内，想要layoutingRect和已布局完成的referenceRect保持水平居中时，layoutingRect的originX
    func minXHorizontallyCenter(_ layoutingRect: CGRect) -> CGFloat {
        return minX + minXHorizontallyCenter(in: layoutingRect)
    }

    /// 为给定的rect往内部缩小insets的大小
    func insetEdges(_ insets: UIEdgeInsets) -> CGRect {
        let newX = minX + insets.left
        let newY = minY + insets.top
        let newWidth = width - insets.horizontalValue
        let newHeight = height - insets.verticalValue
        return CGRect(x: newX, y: newY, width: newWidth, height: newHeight)
    }

    mutating func float(top: CGFloat) -> CGRect {
        origin.y = top
        return self
    }

    mutating func float(bottom: CGFloat) -> CGRect {
        origin.y = bottom - height
        return self
    }

    mutating func float(right: CGFloat) -> CGRect {
        origin.x = right - width
        return self
    }

    mutating func float(left: CGFloat) -> CGRect {
        origin.x = left
        return self
    }

    /// 保持rect的左边缘不变，改变其宽度，使右边缘靠在right上
    mutating func limit(right: CGFloat) -> CGRect {
        size.width = right - minX
        return self
    }

    /// 保持rect右边缘不变，改变其宽度和origin.x，使其左边缘靠在left上。只适合那种右边缘不动的view
    /// 先改变origin.x，让其靠在offset上
    /// 再改变size.width，减少同样的宽度，以抵消改变origin.x带来的view移动，从而保证view的右边缘是不动的
    mutating func limit(left: CGFloat) -> CGRect {
        let subOffset = left - minX
        origin.x = left
        size.width -= subOffset
        return self
    }

    /// 限制rect的宽度，超过最大宽度则截断，否则保持rect的宽度不变
    mutating func limit(maxWidth: CGFloat) -> CGRect {
        size.width = width > maxWidth ? maxWidth : width
        return self
    }

    mutating func setX(_ x: CGFloat) -> CGRect {
        origin.x = flat(x)
        return self
    }

    mutating func setY(_ y: CGFloat) -> CGRect {
        origin.y = flat(y)
        return self
    }

    mutating func setXY(_ x: CGFloat, _ y: CGFloat) {
        origin.x = flat(x)
        origin.y = flat(y)
    }

    mutating func setWidth(_ width: CGFloat) -> CGRect {
        size.width = flat(width)
        return self
    }

    mutating func setHeight(_ height: CGFloat) -> CGRect {
        size.height = flat(height)
        return self
    }

    mutating func setSize(size: CGSize) -> CGRect {
        self.size = size.flatted
        return self
    }
}
