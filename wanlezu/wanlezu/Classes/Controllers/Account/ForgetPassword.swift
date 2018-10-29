//
//  ForgetPassword.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Eureka

class ForgetPassword: GroupedController {

    private var codeButton: UIButton!

    private var timer: DispatchSourceTimer?

    public var phoneNumber: String?

    override func initForm() {
        title = "重设密码"

        let section = Section("header") {
            $0.header = HeaderFooterView<AccountHeaderView>(.class)
        }

        form +++
            section
            <<< PasswordRow("new_password") {
                $0.tag = "new_password"
                $0.placeholder = "请设置新密码（不小于6位）"
            }
            <<< IntRow("verification_code") { [unowned self] textRow in
                self.codeButton = Widget.createRightBtn(with: textRow.cell.textField, width: 90, title: "获取验证码", target: self, action: #selector(self.getverificationCodeAction))
                textRow.placeholder = "请输入验证码"
                textRow.tag = "verification_code"
            }

        let headerView = section.headerView as? AccountHeaderView
        headerView?.text = phoneNumber
    }

    override func initSubviews() {

        let footerView = Widget.generateFooterButton(with: "提交", target: self, action: #selector(submitAction))
        tableView.tableFooterView = footerView
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        timer?.cancel()
        timer = nil
    }

    func getverificationCodeAction(sender: UIButton) {
        waitingCode(button: sender)
    }

    func waitingCode(button: UIButton) {
        var _timeOut = 60
        timer = DispatchSource.makeTimerSource(queue: .main)
        timer?.scheduleRepeating(wallDeadline: .now(), interval: .seconds(1))
        timer?.setEventHandler {
            if _timeOut > 0 {
                button.titleLabel?.textAlignment = .center
                button.titleLabel?.text = "剩余\(_timeOut == 60 ? 60 : _timeOut % 60)秒"
            } else {
                button.titleLabel?.text = "获取验证码"
                self.timer?.cancel()
            }
            _timeOut -= 1
        }
        // 启动定时器
        timer?.resume()
    }

    func submitAction() {
        _ = navigationController?.popViewController(animated: true)
    }
}
