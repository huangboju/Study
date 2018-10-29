//
//  Copyright © 2016年 xiAo_Ju. All rights reserved.
//

import Eureka

// MARK: SegueCell

public class SegueCellOf<T: Equatable>: Cell<T>, CellType {

    required public init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func update() {
        super.update()
        selectionStyle = row.isDisabled ? .none : .default
        accessoryType = .none
        editingAccessoryType = accessoryType
        textLabel?.textAlignment = .center
        textLabel?.textColor = tintColor
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        tintColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        textLabel?.textColor  = UIColor(red: red, green: green, blue: blue, alpha: row.isDisabled ? 0.3 : 1.0)
    }

    public override func didSelect() {
        super.didSelect()
        row.deselect()
    }
}

// MARK: SegueRow

public class _SegueRowOf<T: Equatable> : Row<SegueCellOf<T>> {
    public var controller: UIViewController.Type?

    required public init(tag: String?) {
        super.init(tag: tag)
        displayValueFor = nil
        cellStyle = .default
    }

    public override func customDidSelect() {
        super.customDidSelect()
        if !isDisabled, let controller = controller {
            let controller = controller.init()
            let _cell = cell.formCell()
            let dict: [String : Any?] = [
                UIResponder.Keys.controller: controller,
                UIResponder.Keys.tag: _cell?.baseRow.tag
            ]
            _cell?.router(with: UIResponder.EventName.segueEvent, userInfo: dict)
            cell.formViewController()?.transion(to: controller)
        }
    }

    public override func customUpdateCell() {
        super.customUpdateCell()
        let leftAligmnment = controller != nil
        cell.textLabel?.textAlignment = leftAligmnment ? .left : .center
        cell.accessoryType = !leftAligmnment || isDisabled ? .none : .disclosureIndicator
        cell.editingAccessoryType = cell.accessoryType
        if !leftAligmnment {
            var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
            cell.tintColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
            cell.textLabel?.textColor  = UIColor(red: red, green: green, blue: blue, alpha:isDisabled ? 0.3 : 1.0)
        } else {
            cell.textLabel?.textColor = nil
        }
    }
}

/// A generic row with a button. The action of this button can be anything but normally will push a new view controller
public final class SegueRowOf<T: Equatable> : _SegueRowOf<T>, RowType {
    public required init(tag: String?) {
        super.init(tag: tag)
    }
}

/// A row with a button and String value. The action of this button can be anything but normally will push a new view controller
public typealias SegueRow = SegueRowOf<String>
