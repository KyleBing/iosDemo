//
//  PickerViewVC.swift
//
//  Created by Kyle on 2020/3/13.
//  Copyright © 2020 Cyan Maple. All rights reserved.
//

/// UIPickerView 可以使用 delegate 来实现数据的选中操作
/// UIDatePicker 不能使用 delegate，只能添加对应的 valueChange 事件，调用方法来实现改变对应的数值

import UIKit

class PickerViewVC: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateStartLabel: UILabel!
    @IBOutlet weak var dateEndLabel: UILabel!

    // MARK: - Variables - Frame
    /// picker view tag
    let namePickerViewTag = 1
    let datePickerViewTag = 2
    
    /// picker height
    let pickerHeight: CGFloat = 300
    
    var safaBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else {
            return 0
        }
    }
    /// picker bg color
    let pickerBgColor = UIColor(red: 0xee/0xff, green: 0xee/0xff, blue: 0xee/0xff, alpha: 1)
    /// picker frame
    var pickerFrame: CGRect {
        return  CGRect(x: 0 , y: view.frame.maxY, width: view.frame.width, height: pickerHeight)
    }
    
    var datePickerView: UIDatePicker {
        if let picker = view.viewWithTag(datePickerViewTag) as? UIDatePicker {
            return picker
        } else {
            let picker = UIDatePicker(frame: pickerFrame)
            picker.locale = Locale(identifier: "zh_CN") // 设置 picker 的 locale，设置成中文的
            picker.tag = datePickerViewTag
            picker.datePickerMode = .date // 设置 picker 选择时间的格式
            picker.backgroundColor = pickerBgColor // 设置 picker 背景
            // 添加变化响应事件
            picker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
            view.addSubview(picker)
            UIView.transition(with: picker, duration: 0.3, options: [.curveEaseIn], animations: { [unowned self] in
                picker.center = CGPoint(x: picker.center.x, y: picker.center.y - self.pickerHeight - self.safaBottom)
            }, completion: nil)
            return picker
        }
    }
    
    // MARK: - Vriables - Data
    var names = ["Kyle", "Tina", "Lucy", "Jhon", "Kim", "Ban"]
    var dateStart: Date?
    var dateEnd: Date?
    
    
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table Delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: // click on cell 1
            datePickerView.removeFromSuperview()
            nameLabel.textColor = UIColor.green
            let pickerView = UIPickerView(frame: pickerFrame)
            pickerView.tag = namePickerViewTag
            pickerView.dataSource = self
            pickerView.delegate = self
            pickerView.backgroundColor = pickerBgColor
            UIView.transition(with: pickerView, duration: 0.3, options: [.curveEaseIn], animations: { [unowned self] in
                pickerView.center = CGPoint(x: pickerView.center.x, y: pickerView.center.y - self.pickerHeight - self.safaBottom)
                }, completion: nil)
            view.addSubview(pickerView)
        case 1:
            dateStartLabel.textColor = UIColor.green
            datePickerView.setDate(dateStart ?? Date(), animated: true) // 动画改变数值，picker 会滚动到设定的值，如果直接给 picker.date 赋值就不会有动画了
        case 2:
            dateEndLabel.textColor = UIColor.green
            datePickerView.setDate(dateEnd ?? Date(), animated: true)
        default: break
        }
    }
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            nameLabel.textColor = UIColor.systemGray // 恢复原色
            let pickerView = view.viewWithTag(namePickerViewTag)
            pickerView?.removeFromSuperview() // 取消选中时移除该 picker view
        case 1:
            dateStartLabel.textColor = UIColor.systemGray
        case 2:
            dateEndLabel.textColor = UIColor.systemGray
        default: break
        }
    }
    
    
    // MARK: - Picker Datasource and delegate
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return names.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return names[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        nameLabel.text = names[row]
    }
    
    
    // MARK: - User methods
    
    // Picker methods
    @objc func datePickerValueChanged() {
        if let row = tableView.indexPathForSelectedRow?.row {
            switch row {
            case 1:
                dateStartLabel.text = datePickerView.date.longDateString
                dateStart = datePickerView.date
            case 2:
                dateEndLabel.text = datePickerView.date.longDateString
                dateEnd = datePickerView.date
            default: break
            }
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "FinishEditing":break
            default:
                break
            }
        }
        
    }
    
    
    // MARK: - Tool Methods - Alert
    func showAlert(title: String, message: String, buttonTitle: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (action) in
        })
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}
