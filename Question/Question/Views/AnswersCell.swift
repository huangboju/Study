//
//  AnswersCell.swift
//  Question
//
//  Created by 泽i on 2017/7/8.
//  Copyright © 2017年 huangboju. All rights reserved.
//

enum AnswerType: String {
    case correct = "correct"
    case wrong = "wrong"
    case unselected = "unselected"
}


class AnswersCell: UITableViewCell {
    public var answers: [Answer]? {
        didSet {
            guard let answers = answers else { return }
            for (i, answer) in answers.enumerated() {
                let button = buttons[i]
                button.setImage(UIImage(named: "ic_" + answer.type.rawValue), for: .normal)
                button.setTitle(answer.idx.description, for: .normal)
                button.isHidden = false
            }
        }
    }
    
    private var buttons: [UIButton] = []
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none

        // 5 为5条分割线的宽度
        let count = AnswersController.count
        let itemWidth = (BODY_WIDTH - PADDING_2 - CGFloat(count - 1)) / CGFloat(count)
        for i in 0 ..< AnswersController.count {
            let button = UIButton(frame: CGRect(x: PADDING + (itemWidth + 1) * CGFloat(i), y: 10, width: itemWidth, height: 60))
            button.isUserInteractionEnabled = false
            button.set("-", with: UIImage(named: "ic_unselected"))
            button.setTitleColor(.black, for: .normal)
            button.isHidden = true
            contentView.addSubview(button)
            buttons.append(button)

            if i != count - 1 {
                let separator = CALayer()
                separator.frame = CGRect(x: button.frame.width, y: 0, width: 1, height: button.frame.height)
                separator.backgroundColor = UIColor(white: 0.8, alpha: 1).cgColor
                button.layer.addSublayer(separator)
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
