//
//  QMUIButton.swift
//  QMUI.swift
//
//  Created by 伯驹 黄 on 2017/1/17.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

/// 控制图片在UIButton里的位置，默认为QMUIButtonImagePositionLeft
enum QMUIButtonImagePosition {
    case top // imageView在titleLabel上面
    case left // imageView在titleLabel左边
    case bottom // imageView在titleLabel下面
    case right // imageView在titleLabel右边
}

enum QMUIGhostButtonColor {
    case blue
    case red
    case green
    case gray
    case white
}

enum QMUIFillButtonColor {
    case blue
    case red
    case green
    case gray
    case white
}

enum QMUINavigationButtonType {
    case normal // 普通导航栏文字按钮
    case bold // 导航栏加粗按钮
    case image // 图标按钮
    case back // 自定义返回按钮(可以同时带有title)
    case close // 自定义关闭按钮(只显示icon不带title)
}

enum QMUIToolbarButtonType {
    case normal // 普通工具栏按钮
    case red // 工具栏红色按钮，用于删除等警告性操作
    case image // 图标类型的按钮
}

enum QMUINavigationButtonPosition: Int {
    case none = -1 // 不处于navigationBar最左（右）边的按钮，则使用None。用None则不会在alignmentRectInsets里调整位置
    case left // 用于leftBarButtonItem，如果用于leftBarButtonItems，则只对最左边的item使用，其他item使用QMUINavigationButtonPositionNone
    case right // 用于rightBarButtonItem，如果用于rightBarButtonItems，则只对最右边的item使用，其他item使用QMUINavigationButtonPositionNone
}

/**
 * 提供以下功能：
 * <ol>
 * <li>highlighted、disabled状态均通过改变整个按钮的alpha来表现，无需分别设置不同state下的titleColor、image</li>
 * <li>支持点击时改变背景色颜色（<i>highlightedBackgroundColor</i>）</li>
 * <li>支持点击时改变边框颜色（<i>highlightedBorderColor</i>）</li>
 * <li>支持设置图片在按钮内的位置，无需自行调整imageEdgeInsets（<i>imagePosition</i>）</li>
 * </ol>
 */
class QMUIButton: UIButton {
    /**
     * 让按钮的文字颜色自动跟随tintColor调整（系统默认titleColor是不跟随的）<br/>
     * 默认为NO
     */
    @IBInspectable var adjustsTitleTintColorAutomatically = false {
        didSet {
            updateTitleColorIfNeeded()
        }
    }

    /**
     * 让按钮的图片颜色自动跟随tintColor调整（系统默认image是需要更改renderingMode才可以达到这种效果）<br/>
     * 默认为NO
     */
    @IBInspectable var adjustsImageTintColorAutomatically = false {
        didSet {
            let valueDifference = adjustsImageTintColorAutomatically != oldValue
            if valueDifference {
                updateImageRenderingModeIfNeeded()
            }
        }
    }

    /**
     * 是否自动调整highlighted时的按钮样式，默认为YES。<br/>
     * 当值为YES时，按钮highlighted时会改变自身的alpha属性为<b>ButtonHighlightedAlpha</b>
     */
    @IBInspectable var adjustsButtonWhenHighlighted = true

    /**
     * 是否自动调整disabled时的按钮样式，默认为YES。<br/>
     * 当值为YES时，按钮disabled时会改变自身的alpha属性为<b>ButtonDisabledAlpha</b>
     */
    @IBInspectable var adjustsButtonWhenDisabled = true

    /**
     * 设置按钮点击时的背景色，默认为nil。
     * @warning 不支持带透明度的背景颜色。当设置<i>highlightedBackgroundColor</i>时，会强制把<i>adjustsButtonWhenHighlighted</i>设为NO，避免两者效果冲突。
     * @see adjustsButtonWhenHighlighted
     */
    @IBInspectable var highlightedBackgroundColor: UIColor?

    /**
     * 设置按钮点击时的边框颜色，默认为nil。
     * @warning 当设置<i>highlightedBorderColor</i>时，会强制把<i>adjustsButtonWhenHighlighted</i>设为NO，避免两者效果冲突。
     * @see adjustsButtonWhenHighlighted
     */
    @IBInspectable var highlightedBorderColor: UIColor? {
        didSet {
            if highlightedBorderColor != nil {
                // 只要开启了highlightedBorderColor，就默认不需要alpha的高亮
                adjustsButtonWhenHighlighted = false
            }
        }
    }

    /**
     * 设置按钮里图标和文字的相对位置，默认为QMUIButtonImagePositionLeft<br/>
     * 可配合imageEdgeInsets、titleEdgeInsets、contentHorizontalAlignment、contentVerticalAlignment使用
     */
    @IBInspectable var imagePosition: QMUIButtonImagePosition = .left {
        didSet {
            setNeedsLayout()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        didInitialized()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInitialized()
    }

    private var highlightedBackgroundLayer = CALayer()
    private var originBorderColor: UIColor?

    private func didInitialized() {
        adjustsTitleTintColorAutomatically = false
        adjustsImageTintColorAutomatically = false
        tintColor = APPConfigCenter.buttonTintColor
        if !adjustsTitleTintColorAutomatically {
            setTitleColor(tintColor, for: .normal)
        }

        // 默认接管highlighted和disabled的表现，去掉系统默认的表现
        adjustsImageWhenHighlighted = false
        adjustsImageWhenDisabled = false
        adjustsButtonWhenHighlighted = true
        adjustsButtonWhenDisabled = true

        // iOS7以后的button，sizeToFit后默认会自带一个上下的contentInsets，为了保证按钮大小即为内容大小，这里直接去掉，改为一个最小的值。
        // 不能设为0，否则无效；也不能设置为小数点，否则无法像素对齐
        contentEdgeInsets = UIEdgeInsetsMake(1, 0, 1, 0)

        // 图片默认在按钮左边，与系统UIButton保持一致
        imagePosition = .left
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var size = size
        // 如果调用 sizeToFit，那么传进来的 size 就是当前按钮的 size，此时的计算不要去限制宽高
        if bounds.size == size {
            size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude)
        }

        var resultSize = CGSize.zero
        let contentLimitSize = CGSize(width: size.width - contentEdgeInsets.horizontalValue, height: size.height - contentEdgeInsets.verticalValue)
        switch imagePosition {
        case .bottom, .top:
            // 图片和文字上下排版时，宽度以文字或图片的最大宽度为最终宽度
            let imageLimitWidth = contentLimitSize.width - imageEdgeInsets.horizontalValue
            let imageSize = imageView?.sizeThatFits(CGSize(width: imageLimitWidth, height: CGFloat.greatestFiniteMagnitude)) ?? .zero // 假设图片高度必定完整显示

            let titleLimitSize = CGSize(width: contentLimitSize.width - titleEdgeInsets.horizontalValue, height: contentLimitSize.height - imageEdgeInsets.verticalValue - imageSize.height - titleEdgeInsets.verticalValue)
            var titleSize = titleLabel?.sizeThatFits(titleLimitSize) ?? .zero
            titleSize.height = min(titleSize.height, titleLimitSize.height)

            resultSize.width = contentEdgeInsets.horizontalValue
            resultSize.width += max(imageEdgeInsets.horizontalValue + imageSize.width, titleEdgeInsets.horizontalValue + titleSize.width)
            resultSize.height = contentEdgeInsets.verticalValue + imageEdgeInsets.verticalValue + imageSize.height + titleEdgeInsets.verticalValue + titleSize.height

        case .right, .left:
            if imagePosition == .left && titleLabel?.numberOfLines == 1 {

                // QMUIButtonImagePositionLeft使用系统默认布局
                resultSize = super.sizeThatFits(size)

            } else {
                // 图片和文字水平排版时，高度以文字或图片的最大高度为最终高度
                // titleLabel为多行时，系统的sizeThatFits计算结果依然为单行的，所以当QMUIButtonImagePositionLeft并且titleLabel多行的情况下，使用自己计算的结果

                let imageLimitHeight = contentLimitSize.height - imageEdgeInsets.verticalValue
                let imageSize = imageView?.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: imageLimitHeight)) ?? .zero // 假设图片宽度必定完整显示，高度不超过按钮内容

                let titleLimitSize = CGSize(width: contentLimitSize.width - titleEdgeInsets.horizontalValue - imageSize.width - imageEdgeInsets.horizontalValue, height: contentLimitSize.height - titleEdgeInsets.verticalValue)
                var titleSize = titleLabel?.sizeThatFits(titleLimitSize) ?? .zero
                titleSize.height = min(titleSize.height, titleLimitSize.height)

                resultSize.width = contentEdgeInsets.horizontalValue + imageEdgeInsets.horizontalValue + imageSize.width + titleEdgeInsets.horizontalValue + titleSize.width
                resultSize.height = contentEdgeInsets.verticalValue
                resultSize.height += max(imageEdgeInsets.verticalValue + imageSize.height, titleEdgeInsets.verticalValue + titleSize.height)
            }
        }
        return resultSize
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        if bounds.isEmpty {
            return
        }

        if imagePosition == .left {
            return
        }

        let contentSize = CGSize(width: bounds.width - contentEdgeInsets.horizontalValue, height: bounds.height - contentEdgeInsets.verticalValue)
        if imagePosition == .top || imagePosition == .bottom {
            let imageLimitWidth = contentSize.width - imageEdgeInsets.horizontalValue
            let imageSize = imageView?.sizeThatFits(CGSize(width: imageLimitWidth, height: CGFloat.greatestFiniteMagnitude)) ?? CGSize.zero /// 假设图片的高度必定完整显示
            var imageFrame = imageSize.rect

            let titleLimitSize = CGSize(width: contentSize.width - titleEdgeInsets.horizontalValue, height: contentSize.height - imageEdgeInsets.verticalValue - imageSize.height - titleEdgeInsets.verticalValue)
            var titleSize = titleLabel?.sizeThatFits(titleLimitSize) ?? CGSize.zero
            titleSize.height = CGFloat(fminf(Float(titleSize.height), Float(titleLimitSize.height)))
            var titleFrame = titleSize.rect

            switch contentHorizontalAlignment {
            case .left:
                imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
            case .center:
                imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left + CGFloatGetCenter(imageLimitWidth, imageSize.width))
                titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left + CGFloatGetCenter(titleLimitSize.width, titleSize.width))
            case .right:
                imageFrame = imageFrame.setX(bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageSize.width)
                titleFrame = titleFrame.setX(bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - titleSize.width)
            case .fill:
                imageFrame = imageFrame.setX(contentEdgeInsets.left + imageEdgeInsets.left)
                imageFrame = imageFrame.setWidth(imageLimitWidth)
                titleFrame = imageFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                titleFrame = titleFrame.setWidth(titleLimitSize.width)
            }

            if imagePosition == .top {
                switch contentVerticalAlignment {
                case .top:
                    imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                    titleFrame = titleFrame.setY(imageFrame.maxY + imageEdgeInsets.bottom + titleEdgeInsets.top)
                case .center:
                    let contentHeight = imageFrame.height + imageEdgeInsets.verticalValue + titleFrame.height + titleEdgeInsets.verticalValue
                    let minY = CGFloatGetCenter(contentSize.height, contentHeight) + contentEdgeInsets.top
                    imageFrame = imageFrame.setY(minY + imageEdgeInsets.top)
                    titleFrame = titleFrame.setY(imageFrame.maxY + imageEdgeInsets.bottom + titleEdgeInsets.top)
                case .bottom:
                    titleFrame = titleFrame.setY(bounds.height - contentEdgeInsets.bottom - titleEdgeInsets.bottom - titleFrame.height)
                    imageFrame = imageFrame.setY(titleFrame.minY - titleEdgeInsets.top - imageEdgeInsets.bottom - imageFrame.height)
                case .fill:
                    // 图片按自身大小显示，剩余空间由标题占满
                    imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                    titleFrame = titleFrame.setY(imageFrame.maxY + imageEdgeInsets.bottom + titleEdgeInsets.top)
                    titleFrame = titleFrame.setHeight(bounds.height - contentEdgeInsets.bottom - titleEdgeInsets.bottom - titleFrame.minY)
                }
            } else {
                switch contentVerticalAlignment {
                case .top:
                    titleFrame = titleFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                    imageFrame = imageFrame.setY(imageFrame.maxY + imageEdgeInsets.bottom + titleEdgeInsets.top)
                case .center:
                    let contentHeight = titleFrame.height + titleEdgeInsets.verticalValue + imageFrame.height + imageEdgeInsets.verticalValue
                    let minY = CGFloatGetCenter(contentSize.height, contentHeight) + contentEdgeInsets.top
                    titleFrame = titleFrame.setY(minY + titleEdgeInsets.top)
                    imageFrame = imageFrame.setY(titleFrame.maxY + titleEdgeInsets.bottom + imageEdgeInsets.top)
                case .bottom:
                    imageFrame = imageFrame.setY(bounds.height - contentEdgeInsets.bottom - imageEdgeInsets.bottom - imageFrame.height)
                    titleFrame = titleFrame.setY(imageFrame.minY - imageEdgeInsets.top - titleEdgeInsets.bottom - titleFrame.height)
                case .fill:
                    // 图片按自身大小显示，剩余空间由标题占满
                    imageFrame = imageFrame.setY(bounds.height - contentEdgeInsets.bottom - imageEdgeInsets.bottom - imageFrame.height)
                    titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                    titleFrame = titleFrame.setHeight(imageFrame.minY - imageEdgeInsets.top - titleEdgeInsets.bottom - titleFrame.minY)
                }
            }

            imageView?.frame = imageFrame.flatted
            titleLabel?.frame = titleFrame.flatted

        } else if imagePosition == .right {
            let imageLimitHeight = contentSize.height - imageEdgeInsets.verticalValue
            let imageSize = imageView?.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: imageLimitHeight)) ?? .zero // 假设图片宽度必定完整显示，高度不超过按钮内容
            var imageFrame = imageSize.rect

            let titleLimitSize = CGSize(width: contentSize.width - titleEdgeInsets.horizontalValue - imageFrame.width - imageEdgeInsets.horizontalValue, height: contentSize.height - titleEdgeInsets.verticalValue)
            var titleSize = titleLabel?.sizeThatFits(titleLimitSize) ?? .zero
            titleSize.height = min(titleSize.height, titleLimitSize.height)
            var titleFrame = titleSize.rect

            switch contentHorizontalAlignment {
            case .left:
                titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                imageFrame = imageFrame.setX(titleFrame.maxX + titleEdgeInsets.right + imageEdgeInsets.left)
            case .center:
                let contentWidth = titleFrame.width + titleEdgeInsets.horizontalValue + imageFrame.width + imageEdgeInsets.horizontalValue
                let minX = contentEdgeInsets.left + CGFloatGetCenter(contentSize.width, contentWidth)
                titleFrame = titleFrame.setX(minX + titleEdgeInsets.left)
                imageFrame = imageFrame.setX(titleFrame.maxX + titleEdgeInsets.right + imageEdgeInsets.left)
            case .right:
                imageFrame = imageFrame.setX(bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageFrame.width)
                titleFrame = titleFrame.setX(imageFrame.minX - imageEdgeInsets.left - titleEdgeInsets.right - titleFrame.width)
            case .fill:
                // 图片按自身大小显示，剩余空间由标题占满
                imageFrame = imageFrame.setX(bounds.width - contentEdgeInsets.right - imageEdgeInsets.right - imageFrame.width)
                titleFrame = titleFrame.setX(contentEdgeInsets.left + titleEdgeInsets.left)
                titleFrame = titleFrame.setX(imageFrame.minX - imageEdgeInsets.left - titleEdgeInsets.right - titleFrame.minX)
            }

            switch contentVerticalAlignment {
            case .top:
                titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
            case .center:
                titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top + CGFloatGetCenter(contentSize.height, titleFrame.height + titleEdgeInsets.verticalValue))
                imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top + CGFloatGetCenter(contentSize.height, imageFrame.height + imageEdgeInsets.verticalValue))
            case .bottom:
                titleFrame = titleFrame.setY(bounds.height - contentEdgeInsets.bottom - titleEdgeInsets.bottom - titleFrame.height)
                imageFrame = imageFrame.setY(bounds.height - contentEdgeInsets.bottom - imageEdgeInsets.bottom - imageFrame.height)
            case .fill:
                titleFrame = titleFrame.setY(contentEdgeInsets.top + titleEdgeInsets.top)
                titleFrame = titleFrame.setHeight(bounds.height - contentEdgeInsets.bottom - titleEdgeInsets.bottom - titleFrame.minY)
                imageFrame = imageFrame.setY(contentEdgeInsets.top + imageEdgeInsets.top)
                imageFrame = imageFrame.setHeight(bounds.height - contentEdgeInsets.bottom - imageEdgeInsets.bottom - imageFrame.minY)
            }
            imageView?.frame = imageFrame.flatted
            titleLabel?.frame = titleFrame.flatted
        }
    }

    override var isHighlighted: Bool {
        didSet {
            if isHighlighted && originBorderColor == nil {
                // 手指按在按钮上会不断触发setHighlighted:，所以这里做了保护，设置过一次就不用再设置了
                self.originBorderColor = UIColor(cgColor: self.layer.borderColor!)
            }
            // 渲染背景色
            if highlightedBackgroundColor != nil || highlightedBorderColor != nil {
                adjustsButtonHighlighted()
            }

            // 如果此时是disabled，则disabled的样式优先
            if !isEnabled {
                return
            }
            // 自定义highlighted样式
            if adjustsButtonWhenHighlighted {
                if isHighlighted {
                    alpha = APPConfigCenter.buttonHighlightedAlpha
                } else {
                    UIView.animate(withDuration: 0.25) {
                        self.alpha = 1
                    }
                }
            }
        }
    }

    override var isEnabled: Bool {
        didSet {
            if !isEnabled && adjustsButtonWhenDisabled {
                alpha = APPConfigCenter.buttonHighlightedAlpha
            } else {
                UIView.animate(withDuration: 0.25) {
                    self.alpha = 1
                }
            }
        }
    }

    private func adjustsButtonHighlighted() {
        if let highlightedBackgroundColor = highlightedBackgroundColor {

            highlightedBackgroundLayer.qmui_removeDefaultAnimations()
            layer.insertSublayer(highlightedBackgroundLayer, at: 0)

            highlightedBackgroundLayer.frame = bounds
            highlightedBackgroundLayer.cornerRadius = layer.cornerRadius
            highlightedBackgroundLayer.backgroundColor = isHighlighted ? highlightedBackgroundColor.cgColor : UIColor.clear.cgColor

            if let highlightedBorderColor = highlightedBorderColor {
                layer.borderColor = isHighlighted ? highlightedBorderColor.cgColor : originBorderColor?.cgColor
            }
        }
    }

    private func updateTitleColorIfNeeded() {
        if adjustsTitleTintColorAutomatically {
            setTitleColor(tintColor, for: .normal)
        }
        if adjustsTitleTintColorAutomatically, let currentAttributedTitle = currentAttributedTitle {
            let attributedString = NSMutableAttributedString(attributedString: currentAttributedTitle)
            let range = NSRange(location: 0, length: attributedString.length)
            attributedString.addAttribute(NSForegroundColorAttributeName, value: tintColor, range: range)
            setAttributedTitle(attributedString, for: .normal)
        }
    }

    private func updateImageRenderingModeIfNeeded() {
        if currentImage != nil {
            let states: [UIControlState] = [.normal, .highlighted, .disabled]
            for state in states {
                guard let image = self.image(for: state) else {
                    continue
                }

                if adjustsImageTintColorAutomatically {
                    // 这里的image不用做renderingMode的处理，而是放到重写的setImage:forState里去做
                    self.setImage(image, for: state)
                } else {
                    // 如果不需要用template的模式渲染，并且之前是使用template的，则把renderingMode改回Original
                    self.setImage(image.withRenderingMode(.alwaysOriginal), for: state)
                }
            }
        }
    }

    override func setImage(_ image: UIImage?, for state: UIControlState) {
        var tmpImage: UIImage?
        if adjustsImageTintColorAutomatically {
            tmpImage = image?.withRenderingMode(.alwaysTemplate)
        }
        super.setImage(tmpImage, for: state)
    }

    override func tintColorDidChange() {
        super.tintColorDidChange()

        updateTitleColorIfNeeded()

        if adjustsImageTintColorAutomatically {
            updateImageRenderingModeIfNeeded()
        }
    }
}
