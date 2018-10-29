//
//  Copyright © 2017年 huangboju. All rights reserved.
//

protocol BodyViewDelegate: class {
    func didSelected(at idx: Int, with title: String)
}

class BodyView: UIView {
    
    public weak var delegate: BodyViewDelegate?

    public var content: (question: Question, idx: Int)? {
        didSet {
            guard let content = content else {
                return
            }
            imageUrls = content.question.images
            imageUrls.random()

            collectionView.reloadData()

            textView.text = "\(content.idx + 1). " + content.question.text
        }
    }

    fileprivate var imageUrls: [String] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let height = self.frame.height * 0.62
        let side = (height - 12) / 2
        layout.itemSize = CGSize(width: side, height: side).flatted
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 1
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: height).flatted, collectionViewLayout: layout)
        let margin = (self.frame.width - height) / 2
        collectionView.contentInset = UIEdgeInsets(top: 1, left: margin, bottom: 1, right: margin)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .groupTableViewBackground
        return collectionView
    }()

    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.buttonFont
        textView.textColor = .lightGray
        textView.layer.borderWidth = 1
        textView.backgroundColor = .white
        textView.isUserInteractionEnabled = false
        textView.layer.borderColor = UIColor(white: 0.7, alpha: 1).cgColor
        return textView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .groupTableViewBackground

        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "cellID")
        addSubview(collectionView)

        addSubview(textView)
        let y = collectionView.frame.maxY + 10
        textView.frame = CGRect(x: PADDING, y: y, width: BODY_WIDTH, height: frame.height - y - PADDING)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BodyView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageUrls.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath)
    }
}

extension BodyView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let imageCell = (cell as? ImageCell)
        imageCell?.isSelected = false
        imageCell?.content = (imageUrls[indexPath.row], indexPath.row + 1)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ImageCell else { return }
        cell.isSelected = true
        let idx = indexPath.row
        delegate?.didSelected(at: idx, with: imageUrls[idx])
    }
}
