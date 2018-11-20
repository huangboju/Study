//
//  ViewController.swift
//  Bundle
//
//  Created by 伯驹 黄 on 2016/12/21.
//  Copyright © 2016年 伯驹 黄. All rights reserved.
//

import DKImagePickerController
import CTAssetsPickerController
import UIKit

extension Bundle {
    class var DkBundle: Bundle {
        let path = Bundle(for: DKImageResource.self).path(forResource: "DKImagePickerController", ofType: "bundle")!
        //        let path = Bundle(for: DKImageResource.self).resourcePath! + "/DKImagePickerController.bundle"

        return Bundle(path: path)!
    }

    class var CABundle: Bundle {
        //        let path = Bundle(for: CTAssetsPickerController.self).path(forResource: "CTAssetsPickerController", ofType: "bundle")!
        // 这里类名可以随便填写
        let path = Bundle(for: CTAssetCheckmark.self).resourcePath! + "/CTAssetsPickerController.bundle"
        return Bundle(path: path)!
    }
}

extension String {
    var dklocale: String {
        return NSLocalizedString(self, tableName: "DKImagePickerController", bundle: Bundle.DkBundle, value: "", comment: "")
    }

    var calocale: String {
        //        let path = Bundle(for: CTAssetsPickerController.self).path(forResource: "CTAssetsPickerController", ofType: "bundle")!

        let path = Bundle(for: CTAssetCheckmark.self).resourcePath! + "/CTAssetsPickerController.bundle"
        let CABundle = Bundle(path: path)!
        return NSLocalizedString(self, tableName: "CTAssetsPicker", bundle: CABundle, value: "", comment: "")
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("ok".dklocale, "🇫🇯")
        print("Photos".calocale)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
