//
//  SignUp.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Eureka

class SignUp: GroupedController {
    private var codeButton: UIButton!

    private var timer: DispatchSourceTimer?

    override func initForm() {
        title = "注册"

        form +++
            Section("header") {
                $0.tag = "header"
                $0.header = HeaderFooterView<AccountHeaderView>(.class)
            }
            <<< PasswordRow {
                $0.tag = "password"
                $0.placeholder = "请设输入密码"
            }
            <<< IntRow { [unowned self] textRow in
                self.codeButton = Widget.createRightBtn(with: textRow.cell.textField, width: 90, title: "获取验证码", target: self, action: #selector(self.getverificationCodeAction))
                textRow.placeholder = "请输入验证码"
                textRow.tag = "textRow"
            }
            <<< IntRow {
                $0.tag = "verification_code"
                $0.placeholder = "请输入邀请码（选填）"
            }
    }

    override func initSubviews() {

        let footerView = Widget.generateFooterButton(with: title, target: self, action: #selector(signUpAction))
        tableView.tableFooterView = footerView
    }

    func phoneNumber(_ notification: Notification) {
        guard let phoneNumber = notification.object as? String else {
            print("📱 错误")
            return
        }
        let headerView = form.sectionBy(tag: "header")?.headerView as? AccountHeaderView
        headerView?.text = phoneNumber
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

    func signUpAction() {
        _ = navigationController?.popViewController(animated: true)
    }
}
