//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

// 多个UIViewController之间切换可以添加动画
// 当内存警告的时候，可以把当前不是激活状态的ViewController内存释放。所以新的方法确实能有效地节省内存，也能方便地处理内存不足时的资源回收
// 可以把代码更好分开
// http://blog.devtang.com/2012/02/06/new-methods-in-uiviewcontroller-of-ios5/
import UIKit

class ViewController: UIViewController {
    let firstController = FirstController()
    let secondController = SecondController()
    let thirdController = ThirdController()

    var currentViewController: UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow

        addChild(firstController)
        addChild(secondController)
        addChild(thirdController)

        let contentView = UIView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: 300))
        contentView.backgroundColor = UIColor.brown
        contentView.addSubview(thirdController.view)
        view.addSubview(contentView)
        currentViewController = thirdController

        for i in 0 ..< 3 {
            let button = UIButton(frame: CGRect(x: 0, y: 64 + 54 * CGFloat(i), width: view.frame.width, height: 44))
            button.backgroundColor = UIColor.cyan
            button.setTitle(i.description, for: UIControl.State())
            button.tag = 1000 + i
            button.addTarget(self, action: #selector(action), for: .touchUpInside)
            view.addSubview(button)
        }
    }

    @objc func action(_ sender: UIButton) {
        let condition1 = currentViewController == firstController && sender.tag == 1000
        let condition2 = currentViewController == secondController && sender.tag == 1001
        let condition3 = currentViewController == thirdController && sender.tag == 1002
        if condition1 || condition2 || condition3 {
            return
        }
        let oldViewController = currentViewController
        switch sender.tag {
        case 1000:
            transition(from: currentViewController, to: firstController, duration: 0.4, options: .transitionFlipFromLeft, animations: {

            }) { flag in
                self.currentViewController = flag ? self.firstController : oldViewController
            }
        case 1001:
            transition(from: currentViewController, to: secondController, duration: 0.4, options: .transitionCrossDissolve, animations: {

            }) { flag in
                self.currentViewController = flag ? self.secondController : oldViewController
            }
        case 1002:
            transition(from: currentViewController, to: thirdController, duration: 0.4, options: .curveEaseOut, animations: {

            }) { flag in
                self.currentViewController = flag ? self.thirdController : oldViewController
            }
        default:
            print("aaaaa")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
