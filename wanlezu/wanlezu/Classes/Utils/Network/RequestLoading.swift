//
//  RequestPlugin.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Moya
import Result

/// show or hide the loading hud
public final class RequestLoading: PluginType {

    private var controller: UIViewController? {
        return UIApplication.shared.keyWindow?.visibleViewController
    }

    public func willSend(_: RequestType, target: TargetType) {
        print("📶 \(target.baseURL)")
        controller?.navigationItem.showTitleView(text: "加载中")
    }

    public func didReceive(_: Result<Response, MoyaError>, target _: TargetType) {
        controller?.navigationItem.hideTitleView()
    }
}
