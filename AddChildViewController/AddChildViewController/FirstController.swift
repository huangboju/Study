//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class FirstController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: view.frame.insetBy(dx: 100, dy: 200))
        label.text = "first"
        view.addSubview(label)
        view.backgroundColor = .red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
