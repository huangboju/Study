//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka

class GroupedController: FormViewController, CommonDelegate {

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

    final override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = APPConfigCenter.background
        initForm()

        initSubviews()
    }

    // 子类重写，只创建表单相关的
    func initForm() {}

    // 子类重写
    func initSubviews() {}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        processMemoryWarning()
    }

    deinit {
        removeObserver()
    }
}

// 处理section的间隔
extension GroupedController {
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if form.allSections.count >= 1 {
//            if form.allSections[section].footer != nil {
//                return super.tableView(tableView, heightForFooterInSection: section)
//            }
//            if let title = form.allSections[section].footer?.title {
//                let height = title.size(font: UIFont.sectionTitleFont).height
//                return height + Constants.padding
//            }
//        }
//        return form.count - 1 == section ? Constants.tablewViewBottomHeight : Constants.sectionFooterHeight
//    }
//
//    override func tableView(_: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if let title = form.allSections[section].header?.title {
//            let height = title.size(font: UIFont.sectionTitleFont).height
//            return height + Constants.padding + (section == 0 ? Constants.offsetV : 0)
//        }
//        return section == 0 ? Constants.sectionHeaderHeight : CGFloat(FLT_MIN)
//    }
}
