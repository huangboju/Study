//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

extension URL {
    func getParameters() -> [String: String] {

        let components = NSURLComponents(url: self, resolvingAgainstBaseURL: false)

        // 取出items，如果為nil就改為預設值 空陣列
        let queryItems = components?.queryItems ?? []

        return queryItems.reduce([String: String]()) {
            var dict = $0
            dict[$1.name] = $1.value ?? ""
            return dict
        }
    }
}
