//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

extension Dictionary {
    var toQueryStr: String {
        return self.reduce("") { $0 + ($0 == "" ? "" : "&") + "\($1.0)=\($1.1)" }
    }

    mutating func merge(with dictionary: Dictionary) {
        dictionary.forEach { updateValue($1, forKey: $0) }
    }

    func merged(with dictionary: Dictionary) -> Dictionary {
        var dict = self
        dict.merge(with: dictionary)
        return dict
    }
}
