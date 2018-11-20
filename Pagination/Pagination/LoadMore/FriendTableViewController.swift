//
//  FriendTableViewController.swift
//  Pagination
//
//  Created by 伯驹 黄 on 2016/10/18.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit

class FriendTableViewController: UITableViewController {
    var nextPageState = NextPageState<Int>()
    var data: [Friend] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 10, execute: {
            self.loadNext()
        })

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in _: UITableView) -> Int {
        return 1
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension FriendTableViewController: NextPageLoadable {
    func performLoad(successHandler: ([Friend], Bool, Int?) -> Void, failHandler _: () -> Void) {
        print("performLoad")
        successHandler([Friend](), true, 2)
    }
}
