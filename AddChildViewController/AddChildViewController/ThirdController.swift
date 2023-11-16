//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import UIKit

class ThirdController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel(frame: view.frame.insetBy(dx: 100, dy: 200))
        label.text = "third"
        view.addSubview(label)
        view.backgroundColor = .blue
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(self)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
