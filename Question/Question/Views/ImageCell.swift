//
//  Copyright © 2017年 huangboju. All rights reserved.
//

import Kingfisher

class ImageCell: UICollectionViewCell {
    
    public var content: (urlStr: String, idx: Int)? {
        didSet {
            guard let content = content, let url =  URL(string: content.urlStr) else {
                return
            }
            badge.text = content.idx.description
            
            imageView.kf.setImage(with: url, options: [.transition(.fade(0.25))])
        }
    }

    override var isSelected: Bool {
        didSet {
            checkLayer.removeFromSuperlayer()
            if isSelected {
                contentView.layer.addSublayer(checkLayer)
            }
        }
    }

    private lazy var checkLayer: CheckLayer = {
        return CheckLayer(frame: self.bounds)
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: self.bounds.insetBy(dx: 1, dy: 1))
        return imageView
    }()

    private lazy var badge: UILabel = {
        let badge = UILabel(frame: CGSize(width: 20, height: 20).rect)
        badge.font = UIFont.smallSystemFont
        badge.textAlignment = .center
        return badge
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white

        contentView.addSubview(imageView)

        contentView.addSubview(badge)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CheckLayer: CAShapeLayer {
    convenience init(frame: CGRect) {
        self.init()
        self.frame = frame
        
        fillColor = nil
        strokeColor = APPConfigCenter.app.cgColor
        lineWidth = 2
        path = UIBezierPath(rect: frame).cgPath
    }
}
