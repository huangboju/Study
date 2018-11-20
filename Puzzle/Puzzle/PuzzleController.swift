//
//  ViewController.swift
//  UICollectionViewDemo
//
//  Created by 伯驹 黄 on 2016/11/28.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

let ScreenW = UIScreen.main.bounds.width
let ScreenH = UIScreen.main.bounds.height

enum Direction: CustomStringConvertible {
    case ruler(Int, Int)

    var description: String {
        switch self {
        case let .ruler(row, col):
            if (row, col) == (0, -1) {
                return "U"
            } else if (row, col) == (0, 1) {
                return "D"
            } else if (row, col) == (1, 0) {
                return "R"
            } else if (row, col) == (-1, 0) {
                return "L"
            }
            return "Error"
        }
    }
}

class PuzzleController: UIViewController {

    fileprivate lazy var whiteCellIndexPath = IndexPath(item: 0, section: 0)
    fileprivate lazy var directions: [String] = []

    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        var rect = self.view.frame
        let width = layout.fixSlit(rect: &rect, colCount: 4, space: 1)
        layout.itemSize = CGSize(width: width, height: width)
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 1

        let collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.contentInset.top = (ScreenH - 64 - 4 * width - 3) / 2
        collectionView.backgroundColor = .groupTableViewBackground
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue

        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        view.addSubview(collectionView)

        let button = UIButton(frame: CGRect(x: 15, y: ScreenW + 30, width: ScreenW - 30, height: 44))
        button.layer.cornerRadius = 3
        button.setTitle("完成", for: .normal)
        button.backgroundColor = UIColor(red: 144 / 255, green: 238 / 255, blue: 144 / 255, alpha: 1)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        collectionView.addSubview(button)

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(restart))
    }

    func restart() {
        whiteCellIndexPath = IndexPath(item: 0, section: 0)
        directions.removeAll()
        collectionView.reloadData()
    }

    func buttonAction() {
        let str = directions.reduce("", +) + "\n\(directions.count)step"

        let alert = UIAlertController(title: nil, message: str, preferredStyle: .alert)
        present(alert, animated: true, completion: nil)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            alert.dismiss(animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PuzzleController: UICollectionViewDataSource {
    func numberOfSections(in _: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
}

extension PuzzleController: UICollectionViewDelegate {
    func collectionView(_: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath == IndexPath(item: 0, section: 0) {
            cell.backgroundColor = UIColor.white
        } else if indexPath.row > 1 {
            cell.backgroundColor = UIColor.blue
        } else {
            cell.backgroundColor = UIColor.red
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == whiteCellIndexPath.row || indexPath.section == whiteCellIndexPath.section {
            let row = indexPath.row - whiteCellIndexPath.row
            let col = indexPath.section - whiteCellIndexPath.section
            if abs(row) == 1 || abs(col) == 1 {
                directions.append(Direction.ruler(row, col).description)
                let whiteCell = collectionView.cellForItem(at: whiteCellIndexPath)
                let colorCell = collectionView.cellForItem(at: indexPath)
                whiteCell?.backgroundColor = colorCell?.backgroundColor
                colorCell?.backgroundColor = UIColor.white
                whiteCellIndexPath = indexPath
            }
        }
    }
}
