//
//  APIProvider.swift
//  wanlezu
//
//  Created by 伯驹 黄 on 2017/6/16.
//  Copyright © 2017年 伯驹 黄. All rights reserved.
//

import Moya

enum API {
    case none
    case phoneNumber(String)
    case signIn([String: Any])
}

extension API: TargetType {
    public var baseURL: URL {
        return URL(string: "https://httpbin.org/get")!
    }

    public var path: String {
        switch self {
        case .phoneNumber:
            return ""
        case .signIn:
            return ""
        default:
            return ""
        }
    }

    public var method: Moya.Method {
        switch self {
        case .phoneNumber:
            return .get
        default:
            return .get
        }
    }

    public var parameters: [String: Any]? {
        switch self {
        case let .phoneNumber(str):
            return ["phoneNumber": str]
        case let .signIn(dict):
            return dict
        default:
            return nil
        }
    }

    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    // Local data for unit test.use empty data temporarily.
    public var sampleData: Data {
        return "".data(using: .utf8)!
    }

    // Represents an HTTP task.
    public var task: Task {
        switch self {
        case .phoneNumber:
            return .request
        default:
            return .request
        }
    }
}
