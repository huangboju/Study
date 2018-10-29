//
//  Copyright © 2016年 Jack. All rights reserved.
//  Created by KingCQ on 16/8/3.
//

import Foundation

extension Bundle {

    static var releaseVersionNumber: String {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
    }

    static var releaseVersionName: String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }

    static var buildVersionNumber: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }

    static var displayName: String {
        return Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String ?? ""
    }
}
