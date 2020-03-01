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
        (name: "Animation",                 comment: "",                    identifier: "Animation"),
        (name: "Animcation Dynamic",        comment: "",                    identifier: "AnimationDynamic"),
        (name: "Button Stage",              comment: "",                    identifier: "ButtonStage"),
        (name: "Web VC",                    comment: "Web View Controller", identifier: "WebVC"),
        (name: "Banner",                    comment: "Collection View",     identifier: "BannerVC"),
        (name: "Navigation Bar",            comment: "",                    identifier: "NavigationBar"),
        (name: "Rounded Rect",              comment: "",                    identifier: "RoundedRect"),
        (name: "Collection View",           comment: "",                    identifier: "CollectionView"),
        (name: "Stack View",                comment: "",                    identifier: "StackView"),
        (name: "UNNotification Center",     comment: "",                    identifier: "UNNotificationCenter"),
        (name: "Page View Controller",      comment: "",                    identifier: "PageViewController"),
        (name: "Page View Inside",          comment: "",                    identifier: "PageViewInside"),
        (name: "Health Infos",              comment: "",                    identifier: "HealthInfos"),
        (name: "Mapkit",                    comment: "Gaode Map UNFINISHED",identifier: "MapVC"),
        (name: "Window Views",              comment: "" ,                   identifier: "Customised View"),


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
        cell.textLabel?.text = list[indexPath.row].name
        cell.detailTextLabel?.text = list[indexPath.row].comment
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
