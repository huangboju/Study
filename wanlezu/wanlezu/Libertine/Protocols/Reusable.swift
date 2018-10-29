//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//  Created by KingCQ on 16/8/17.
//

import UIKit

public protocol Reusable: class {
    static var reuseIdentifier: String { get }
}

public extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
