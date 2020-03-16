//
//  HomeTableVC.swift
//  CustomisedViews
//
//  Created by Kyle on 2017/5/29.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class HomeTableVC: UITableViewController {
    let list = [
        (title: "PickerViewVC",              identifier: "PickerViewVC",       subtitle: ""),
        (title: "LoginWithKeychain",         identifier: "LoginWithKeychain",       subtitle: ""),
        (title: "UIPasteBoard",              identifier: "UIPasteBoard",       subtitle: ""),
        (title: "URLSession",                identifier: "URLSession",       subtitle: ""),
        (title: "Authentication",            identifier: "Authentication",   subtitle: ""),
        (title: "Animation",                 identifier: "Animation",        subtitle: "basic"),
        (title: "Animcation Dynamic",        identifier: "AnimationDynamic", subtitle: "dynamic"),
        (title: "Button Stage",              identifier: "ButtonStage",      subtitle: ""),
        (title: "Web VC",                    identifier: "WKWebview",        subtitle: "Web View Controller"),
        (title: "Banner",                    identifier: "BannerVC",         subtitle: "Collection View"),
        (title: "Navigation Bar",            identifier: "NavigationBar",    subtitle: ""),
        (title: "Rounded Rect",              identifier: "RoundedRect",      subtitle: ""),
        (title: "Collection View",           identifier: "CollectionView",   subtitle: ""),
        (title: "Stack View",                identifier: "StackView",        subtitle: ""),
        (title: "User Notification",         identifier: "UserNotification", subtitle: ""),
        (title: "Page View Controller",      identifier: "PageViewController", subtitle: ""),
        (title: "Page View Inside",          identifier: "PageViewInside",   subtitle: ""),
        (title: "Health Infos",              identifier: "HealthInfos",      subtitle: "HealthKit"),
        (title: "Mapkit",                    identifier: "MapVC",            subtitle: "Gaode Map UNFINISHED"),
        (title: "Window Views",              identifier: "Customised View",  subtitle: "" ),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.tintColor = Colors.navigationBarTintColor
        }
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
    }
    
    // MARK: - Table view delegete
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell")!
        cell.textLabel?.text = list[indexPath.row].title
        cell.detailTextLabel?.text = list[indexPath.row].subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: list[index].identifier)
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
