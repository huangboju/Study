//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka

class Developer: GroupedController {
    
    override func initForm() {

        form +++ SwitchRow("developer") {
            $0.title = $0.tag?.local
            $0.value = APPDefaults[.developer]
        }.onChange {
            APPDefaults[.developer] = $0.value ?? false
        }
    }
}
