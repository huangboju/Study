//
//  TableList.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

class TableListController<T: BaseModel, C: UITableViewCell>: ServiceController<T, C>, UITableViewDataSource, UITableViewDelegate, ListPresenter {

    public var listView: UITableView!

    final override func initListView() {
        listView = UITableView(frame: view.frame)
        listView.delegate = self
        listView.dataSource = self
        listView.register(C.self, forCellReuseIdentifier: cellID)
        addRefreshControl()
        view.addSubview(listView)
    }

    // MARK: - UITableViewDataSource
    final func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.isEmpty ? 0 : data[section].count
    }

    final func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
    }

    // MARK: - UITableViewDataSource
    final func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        willDisplay(cell as! C, forRowAt: indexPath, item: data[indexPath.section][indexPath.row])
    }

    final func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRow(at: indexPath, item: data[indexPath.section][indexPath.row])
    }
}
