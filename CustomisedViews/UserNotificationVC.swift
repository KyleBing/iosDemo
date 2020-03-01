//
//  UserNotificationVC.swift
//  CustomisedViews
//
//  Created by Kyle on 2017/6/19.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit
import UserNotifications

class UserNotificationVC: UIViewController, UNUserNotificationCenterDelegate {

    @IBOutlet weak var displayTextView: UITextView!
    
    let center = UNUserNotificationCenter.current()
    let CATEGORY_IDENTIFIER = "CATEGORY_YES_NO"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UNUntificationCenter Delegate
        center.delegate = self
        
        // Bar Button Items
        let buttonFire              = UIBarButtonItem(title: "加", style: .plain, target: self, action: #selector(fireNotification))
        let buttonShow              = UIBarButtonItem(title: "看", style: .plain, target: self, action: #selector(showAllNotifications))
        let buttonClear             = UIBarButtonItem(title: "删", style: .plain, target: self, action: #selector(clearNotifications))
        let buttonClearDisplay      = UIBarButtonItem(title: "清", style: .plain, target: self, action: #selector(clearDisplay))
        navigationItem.rightBarButtonItems = [buttonClear, buttonShow, buttonFire, buttonClearDisplay]

        
        if #available(iOS 13.0, *) {
            center.requestAuthorization(options: [.alert, .badge, .sound, .announcement]) { (success, error) in
                if success {
                    DispatchQueue.main.async {
                        self.displayTextView.text = "获取通知权限成功: .alert .badge .sound"
                    }
                } else {
                    DispatchQueue.main.async {
                        self.displayTextView.text = "！！获取通知权限失败！！"
                        self.navigationItem.rightBarButtonItems = nil // clear buttons
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    
    // MARK: - UNNotificationCenter Delegate
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void)
    {
        // update app badge icon number
        center.getPendingNotificationRequests { (requests) in
            DispatchQueue.main.async {
                UIApplication.shared.applicationIconBadgeNumber = requests.count
            }
        }
                
        let request = response.notification.request
        switch response.actionIdentifier {
        case "buttonYes":

            DispatchQueue.main.async {
                self.displayTextView.text += "----------------\n"
                self.displayTextView.text += "IDENTIFIER: \(request.identifier) - BUTTON: \(response.actionIdentifier)\n"
                self.displayTextView.text += "此内容是点击通知中的 Yes 按钮后显示的"
            }
        case "buttonNo":
            DispatchQueue.main.async {
                self.displayTextView.text += "----------------\n"
                self.displayTextView.text += "IDENTIFIER: \(request.identifier) - BUTTON: \(response.actionIdentifier)\n"
                self.displayTextView.text += "此内容是点击通知中的 No 按钮后显示的"
            }
        default: break
        }
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        center.getPendingNotificationRequests { (requests) in
            DispatchQueue.main.async {
                UIApplication.shared.applicationIconBadgeNumber = 11
                self.displayTextView.text += "通知已在前台显示\n"
            }
        }
    }
    
    // MARK: - Button Action Functions
    @objc func fireNotification () {
        
        // content
        let content = UNMutableNotificationContent()
        content.title = "通知测试"
        content.subtitle = "from CustomisedViews"
        content.body = "测试 UNNotification 的 IntervalNotification"
        content.badge = nil
        content.sound = .default
        content.categoryIdentifier = CATEGORY_IDENTIFIER
        
        // trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        // actions
        let actionYes = UNNotificationAction(identifier: "buttonYes", title: "Yes", options: UNNotificationActionOptions(rawValue: 0))
        let actionNo = UNNotificationAction(identifier: "buttonNo", title: "No", options: UNNotificationActionOptions(rawValue: 0))
        
        // category
        if #available(iOS 13.0, *) {
            let category = UNNotificationCategory(
                identifier: CATEGORY_IDENTIFIER,
                actions: [actionYes, actionNo],
                intentIdentifiers: [],
                options: [.allowAnnouncement])
            center.setNotificationCategories([category])
        } else {
            // Fallback on earlier versions
        }

        let request = UNNotificationRequest(identifier: Int.random(in: 1...100).description, content: content, trigger: trigger)
        center.add(request) { (error) in
            self.showAllNotifications()
        }
    }
    
    @objc func clearDisplay() {
        self.displayTextView.text = ""
    }
    
    @objc func showAllNotifications () {
        DispatchQueue.main.async {
            self.displayTextView.text = ""
        }
        // show depending notifications
        center.getPendingNotificationRequests { (requests) in
            DispatchQueue.main.async {
                self.displayTextView.text += "===================\n"
                self.displayTextView.text += "Pending Notifications: \(requests.count) \n"
                self.displayTextView.text += "===================\n"

                for req in requests {
                    let content = req.content
                    let trigger = req.trigger as! UNTimeIntervalNotificationTrigger
                    self.displayTextView.text += "---\n"
                    self.displayTextView.text += " title: \(content.title)\n body: \(content.body)\n badge: \(content.badge ?? 0)\n interval: \(trigger.timeInterval)\n triggerTime: \(trigger.nextTriggerDate()?.shortTimeString ?? "--")\n"
                }
            }
        }
        // show delivered notifications
        center.getDeliveredNotifications(completionHandler: {  ( notifications ) in
            DispatchQueue.main.async {
                self.displayTextView.text += "===================\n"
                self.displayTextView.text += "Delivered Notifications: \(notifications.count) \n"
                self.displayTextView.text += "===================\n"

                for notification in notifications {
                    let content = notification.request.content
                    let trigger = notification.request.trigger as! UNTimeIntervalNotificationTrigger
                    self.displayTextView.text += "---\n"
                    self.displayTextView.text += " title: \(content.title)\n body: \(content.body)\n badge: \(content.badge ?? 0)\n interval: \(trigger.timeInterval)\n triggerTime: \(trigger.nextTriggerDate()?.shortTimeString ?? "--")\n"
                }
            }
        })
    }
    
    @objc func clearNotifications() {
        UIApplication.shared.applicationIconBadgeNumber = 0
        displayTextView.text = "已清除通知"
        center.removeAllDeliveredNotifications()
        center.removeAllPendingNotificationRequests()
    }
}


// MARK: - Extension

extension Date {
    
    var shortDateString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        dateFormatter.locale = Locale(identifier: "zh_CN")
        return dateFormatter.string(from: self)
    }
    
    var shortTimeString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "zh_CN")
        return dateFormatter.string(from: self)
    }
}
