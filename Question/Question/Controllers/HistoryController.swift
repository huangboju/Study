//
//  HistoryController.swift
//  Question
//
//  Created by 黄伯驹 on 2017/7/9.
//  Copyright © 2017年 huangboju. All rights reserved.
//

import MTPopup

class HistoryController: BaseController {
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    fileprivate var data: [User] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func initUI() {
        view.addSubview(tableView)

        data = Widget.getUsers()
    }
}

extension HistoryController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension HistoryController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = data[indexPath.row].nickName
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }

        let vc = AnswersController()
        let user = data[indexPath.row]
        vc.answers = user.answers
        vc.title = user.nickName
        let popupController = MTPopupController(rootViewController: vc)
        popupController.present(in: self)
    }
}
