//
//  PhoneNumber.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/13.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Eureka
import PromiseKit

class PhoneNumber: GroupedController {

    override func initForm() {
        title = "手机号"

        form +++
            Section {
                $0.tag = "header"
                $0.header = HeaderFooterView<AppLogoView>(.class)
            }
            <<< PhoneRow {
                $0.tag = "phoneNumber"
                $0.placeholder = "请输入手机号"
            }
    }

    override func initSubviews() {

        let footerView = Widget.generateFooterButton(with: "下一步", target: self, action: #selector(nextStepAction))
        tableView.tableFooterView = footerView
    }

    func nextStepAction() {
        let inputText = (form.rowBy(tag: "phoneNumber") as? PhoneRow)?.text
        guard inputText?.verify(with: .phoneNumber) ?? false else {
            showAlert(message: "请输入正确的手机号")
            return
        }

        Service<BaseModel>(api: .phoneNumber(inputText!)).request().then { _ -> Void in
            self.postNotification(name: NotificationName.phoneNumber, object: inputText)
            _ = self.navigationController?.popViewController(animated: true)
        }.catch { (error) in
            print(error)
            self.showAlert(message: "请检查网络")
        }
    }
}
