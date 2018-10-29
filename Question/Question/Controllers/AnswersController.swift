//
//  Copyright © 2017年 huangboju. All rights reserved.
//

// 每行显示答案个数

class AnswersController: BaseController {

    static let count = 6
    
    let contentSize = CGSize(width: BODY_WIDTH, height: flat(BODY_WIDTH / 0.618 - TopBarHeight))
    
    public var answers: [Answer] = [] {
        didSet {
            let count = AnswersController.count

            for (i, answer) in answers.enumerated() {
                if _answers.isEmpty || i % count == 0 {
                    _answers.append([answer])
                } else {
                    _answers[i / count].append(answer)
                }
            }
        }
    }
    fileprivate var _answers: [[Answer]] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.contentSize.rect)
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(AnswersCell.self, forCellReuseIdentifier: "cellID")
        return tableView
    }()

    override func initUI() {

        title = title.map { $0 + "的答案" }

        contentSizeInPopup = contentSize
        landscapeContentSizeInPopup = CGSize(width: 400, height: 100)

        view.addSubview(tableView)
        
        // 分割线顶头
        if tableView.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            tableView.separatorInset = .zero
        }
        if tableView.responds(to: #selector(setter: UIView.layoutMargins)) {
            tableView.layoutMargins = .zero
        }
    }
}

extension AnswersController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 进一法除法
        return (answers.count + AnswersController.count - 1) / AnswersController.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath)
    }
}

extension AnswersController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        (cell as? AnswersCell)?.answers = _answers[indexPath.row]
        // 分割线顶头
        if cell.responds(to: #selector(setter: UITableViewCell.separatorInset)) {
            cell.separatorInset = .zero
        }
        if cell.responds(to: #selector(setter: UIView.layoutMargins)) {
            cell.layoutMargins = .zero
        }
    }
}
