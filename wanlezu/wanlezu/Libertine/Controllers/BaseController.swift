//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

open class BaseController: UIViewController, CommonDelegate {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        didInitialized()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        didInitialized()
    }

    init() {
        super.init(nibName: nil, bundle: nil)
        didInitialized()
    }

    open override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = APPConfigCenter.background

        initListView()

        initSubviews()
    }

    // 子类重写
    func initSubviews() {}

    func initListView() {}

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        processMemoryWarning()
    }

    deinit {
        removeObserver()
    }
}
