//
//  SignIn.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Eureka
import SnapKit

class SignIn: GroupedController {

    private var headerView: AccountHeaderView? {
        return form.sectionBy(tag: "header")?.headerView as? AccountHeaderView
    }

    override func initForm() {
        title = "登录"

        form +++
            Section {
                $0.tag = "header"
                $0.header = HeaderFooterView<AccountHeaderView>(.class)
            }
            <<< PasswordRow {
                $0.tag = "password"
                $0.placeholder = "请输入密码"
            }
    }

    override func initSubviews() {
        addObserver(with: #selector(phoneNumber), name: NotificationName.phoneNumber)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .plain, target: self, action: #selector(closeAction))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "切换账号", style: .plain, target: self, action: #selector(exchangeAccountAction))

        transion(to: PhoneNumber(), animated: false)

        let footerView = Widget.generateFooterButton(with: title, target: self, action: #selector(signInAction))
        tableView.tableFooterView = footerView

        footerView.frame.size.height += (PADDING + 34)

        let forgetButton = UIButton()
        footerView.addSubview(forgetButton)
        forgetButton.addTarget(self, action: #selector(forgetPasswordAction), for: .touchUpInside)
        forgetButton.setTitle("忘记密码", for: .normal)
        forgetButton.setTitleColor(APPConfigCenter.black, for: .normal)
        forgetButton.snp.makeConstraints { make in
            make.right.equalTo(-PADDING)
            make.bottom.equalTo(0)
            make.width.equalTo(80)
        }
    }

    func phoneNumber(_ notification: Notification) {
        guard let phoneNumber = notification.object as? String else {
            print("📱 错误")
            return
        }
        headerView?.text = phoneNumber
    }

    // MARK: - Action
    func signInAction() {
        guard let password = (form.rowBy(tag: "password") as? PasswordRow)?.text, !password.isEmpty else {
            showAlert(message: "密码不能为空")
            return
        }

        let dict = [
            "password": "aaa",
            "phone_number": headerView?.text ?? ""
        ]

        Service<BaseModel>(api: .signIn(dict)).request().then { _ -> Void in
            self.dismiss(animated: true, completion: nil)
        }.catch { (error) in
            print(error)
            self.showAlert(message: "请检查网络")
        }
    }

    func forgetPasswordAction() {
        let vc = ForgetPassword()
        vc.phoneNumber = headerView?.text
        transion(to: vc)
    }

    func closeAction() {
        dismiss(animated: true, completion: nil)
    }

    func exchangeAccountAction() {
        transion(to: PhoneNumber())
    }
}
