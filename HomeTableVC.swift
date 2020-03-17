//
//  HomeTableVC.swift
//  iosDemo
//
//  Created by Kyle on 2017/5/29.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

struct HomeListGroup {
    var title: String
    var lists: [(title: String, identifier: String, subtitle: String)]
}

class HomeTableVC: UITableViewController {
    
    let listGroups:[HomeListGroup] = [
        HomeListGroup(title: "UIKit", lists: [
            (title: "Customized Views",          identifier: "Customized View",     subtitle: "customized views" ),
            (title: "ImagePicker",               identifier: "ImagePickerVC",       subtitle: ""),
            (title: "PickerView",                identifier: "PickerViewVC",        subtitle: ""),
            (title: "UIPasteBoard",              identifier: "UIPasteBoard",        subtitle: ""),
            (title: "Animcation Dynamic",        identifier: "AnimationDynamic",    subtitle: "dynamic"),
            (title: "Animation",                 identifier: "Animation",           subtitle: "basic"),
            (title: "Banner",                    identifier: "BannerVC",            subtitle: "Collection View"),
            (title: "Navigation Bar",            identifier: "NavigationBar",       subtitle: ""),
            (title: "Rounded Rect",              identifier: "RoundedRect",         subtitle: ""),
            (title: "Collection View",           identifier: "CollectionView",      subtitle: ""),
            (title: "Stack View",                identifier: "StackView",           subtitle: ""),
            (title: "Page View Controller",      identifier: "PageViewController",  subtitle: ""),
            (title: "Page View Inside",          identifier: "PageViewInside",      subtitle: ""),
            (title: "Button Stage",              identifier: "ButtonStage",         subtitle: ""),
            (title: "Web VC",                    identifier: "WebVC",               subtitle: "Web View Controller"),
            (title: "Mapkit",                    identifier: "MapVC",               subtitle: "Gaode Map UNFINISHED"),
        ]),
        HomeListGroup(title: "User Notification", lists: [
            (title: "User Notification",         identifier: "UserNotification",    subtitle: ""),
        ]),
        
        HomeListGroup(title: "Health Kit", lists: [
            (title: "Health Infos",              identifier: "HealthInfos",         subtitle: "HealthKit"),
        ]),
        
        HomeListGroup(title: "Security", lists: [
            (title: "Authentication",            identifier: "Authentication",      subtitle: ""),
            (title: "LoginWithKeychain",         identifier: "LoginWithKeychain",   subtitle: ""),
        ]),
        
        HomeListGroup(title: "Network", lists: [
            (title: "URLSession",                identifier: "URLSession",          subtitle: ""),
        ]),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.tintColor = Colors.navigationBarTintColor
        }
        /*
        if #available(iOS 11.0, *) {
            // 大标题
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }*/
        title = "iOS Demo"
        let center = UNUserNotificationCenter.current()
        center.removeAllDeliveredNotifications()
    }
    
    // MARK: - Table view delegete
    override func numberOfSections(in tableView: UITableView) -> Int {
        return listGroups.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listGroups[section].lists.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell")!
        let listItem = listGroups[indexPath.section].lists[indexPath.row]
        cell.textLabel?.text = listItem.title
        cell.detailTextLabel?.text = listItem.subtitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listItem = listGroups[indexPath.section].lists[indexPath.row]
        let destVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: listItem.identifier)
        destVC.title = listItem.title
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35.0
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let groupItem = listGroups[section]
        return groupItem.title
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
}
