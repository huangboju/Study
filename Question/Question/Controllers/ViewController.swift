//
//  Copyright © 2017年 huangboju. All rights reserved.
//

class ViewController: BaseController {

    override func initUI() {
        let startBtn = Widget.generateDarkButton(with: "开始测验", target: self, action: #selector(startAction))
        view.addSubview(startBtn)
    
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "历史记录", style: .plain, target: self, action: #selector(historyAction))

        let reView = ReView(frame: CGRect(x: 0, y: 80, width: 80, height: 80))
        reView.center.x = view.center.x
        view.addSubview(reView)
    }

    func historyAction(item: UIBarButtonItem) {
        
        // http://www.devtalking.com/articles/uiview-transition-animation/
        
        let vc = HistoryController()
        vc.title = item.title
        transion(to: .controller(vc))
    }

    /// TextField 不能在present之后添加
    func startAction() {
        let alert = UIAlertController(title: nil, message: "请输入名称，开始测验", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.action("取消", style: .cancel)
        alert.action("确定") { (action) in
            guard let nickName =  alert.textFields?.first?.text, !nickName.isEmpty else { return }
            let vc = DetailController()
            vc.nickName = nickName
            self.transion(to: .controller(vc))
        }
        present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


class ReView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)

        let imageView = UIImageView(image: UIImage(named: "ic_app"))
        imageView.frame.origin.x = (frame.width - imageView.frame.width) / 2
        imageView.frame.origin.y = (frame.height - imageView.frame.height) / 2
        addSubview(imageView)

        //做倒影
        let layer = self.layer as? CAReplicatorLayer
        layer?.instanceCount = 2
        layer?.contentsScale = ScreenScale

        var transform = CATransform3DIdentity
        transform = CATransform3DScale(transform, 1.0, -1.0, 1.0)
        transform = CATransform3DTranslate(transform, 0.0, -60, 1.0)
        layer?.instanceTransform = transform

        //reduce alpha of reflection layer
        layer?.instanceAlphaOffset = -0.6
    }

    override class var layerClass: AnyClass {
        return CAReplicatorLayer.self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


