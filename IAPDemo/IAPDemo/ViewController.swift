//
//  ViewController.swift
//  IAPDemo
//
//  Created by 伯驹 黄 on 2016/12/19.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import UIKit
import StoreKit
import SwiftyStoreKit

class ViewController: UIViewController {
    fileprivate lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()

    lazy var data: [String] = [
        "20161219cmcaifu",
        "20161219cmcaifu1",
        "20161219cmcaifu2",
        "20161219CMCAIFU4",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "IAP"
        tableView.register(ButtonCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }

    // 获取产品信息
    func getInfo(productID: String) {
        navigationItem.showTitleView(with: "loading")
        SwiftyStoreKit.retrieveProductsInfo([productID]) { result in
            self.showAlert(self.alertForProductRetrievalInfo(result))
            self.navigationItem.hideTitleView()
        }
    }

    // 购买
    func purchase(_ productID: String) {
        navigationItem.showTitleView(with: "purchasing")
        SwiftyStoreKit.purchaseProduct(productID, atomically: false) { result in
            if case let .success(product) = result {
                // 模拟服务器验证
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    if product.needsFinishTransaction {
                        let receiptData = SwiftyStoreKit.localReceiptData
                        let receiptString = receiptData?.base64EncodedString(options: [])
                        // 在这里保存订单和receiptString
                        self.navigationItem.prompt = "购买成功"
                        SwiftyStoreKit.finishTransaction(product.transaction)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
                            self.navigationItem.prompt = nil
                        })
                    }
                })
            }
            self.showAlert(self.alertForPurchaseResult(result))
            self.navigationItem.hideTitleView()
        }
    }

    override func router(with eventName: String, userInfo: [String: Any]) {
        if eventName == EventName.transferNameEvent {
            if let value = userInfo[Keys.button] as? IndexPath {
                purchase(data[value.row])
            }
        }
    }

    func alertForPurchaseResult(_ result: PurchaseResult) -> UIAlertController {
        switch result {
        case let .success(product):
            print("Purchase Success: \(product.productId)")
            return alertWithTitle("Thank You", message: "Purchase completed")
        case let .error(error):
            print("Purchase Failed: \(error)")
            switch error {
            case let .failed(error):
                if (error as NSError).domain == SKErrorDomain {
                    return alertWithTitle("Purchase failed", message: "Please check your Internet connection or try again later")
                }
                return alertWithTitle("Purchase failed", message: "Unknown error. Please contact support")
            case let .invalidProductId(productId):
                return alertWithTitle("Purchase failed", message: "\(productId) is not a valid product identifier")
            case .noProductIdentifier:
                return alertWithTitle("Purchase failed", message: "Product not found")
            case .paymentNotAllowed:
                return alertWithTitle("Payments not enabled", message: "You are not allowed to make payments")
            }
        }
    }

    func showAlert(_ alert: UIAlertController) {
        guard let _ = presentedViewController else {
            present(alert, animated: true, completion: nil)
            return
        }
    }

    func alertWithTitle(_ title: String, message: String) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        return alert
    }

    func alertForProductRetrievalInfo(_ result: RetrieveResults) -> UIAlertController {

        if let product = result.retrievedProducts.first {
            let priceString = product.localizedPrice!
            return alertWithTitle(product.localizedTitle, message: "\(product.localizedDescription) - \(priceString)")
        } else if let invalidProductId = result.invalidProductIDs.first {
            return alertWithTitle("Could not retrieve product info", message: "Invalid product identifier: \(invalidProductId)")
        } else {
            let errorString = result.error?.localizedDescription ?? "Unknown error. Please contact support"
            return alertWithTitle("Could not retrieve product info", message: errorString)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    }
}

extension ViewController: UITableViewDelegate {

    func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.textLabel?.text = data[indexPath.row]
        (cell as? ButtonCell)?.indexPath = indexPath
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let productID = data[indexPath.row]
        getInfo(productID: productID)
    }
}
