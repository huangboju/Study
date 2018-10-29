//
//  CollectionListController.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

class CollectionListController<T: BaseModel, C: UICollectionViewCell>: ServiceController<T, C>, UICollectionViewDataSource, UICollectionViewDelegate, ListPresenter {

    public var listView: UICollectionView!

    final override func initListView() {
        listView = UICollectionView(frame: view.frame, collectionViewLayout: UICollectionViewLayout())
        listView.dataSource = self
        listView.delegate = self
        listView.register(C.self, forCellWithReuseIdentifier: cellID)
        addRefreshControl()
        view.addSubview(listView)
    }

    // MARK: - UICollectionViewDataSource
    final func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }

    final func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
    }

    // MARK: - UICollectionViewDelegate
    final func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        willDisplay(cell as! C, forRowAt: indexPath, item: data[indexPath.section][indexPath.row])
    }

    final func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didSelectRow(at: indexPath, item: data[indexPath.section][indexPath.row])
    }
}
