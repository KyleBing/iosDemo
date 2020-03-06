//
//  UIPasteBoardTableVC.swift
//  CustomisedViews
//
//  Created by Kyle on 2020/3/5.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import UIKit


class UIPasteBoardTableVC: UITableViewController {
    
    var lists:[[(key:String, value:String)]] = []
    let pasteBoard = UIPasteboard.general
    let notificationCenter = NotificationCenter.default

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshData()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加内容", style: .plain, target: self, action: #selector(changePasteBoardContent))
        
        // UserNotification
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return lists.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists[section].count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String(section + 1)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PasteBoardCell", for: indexPath)
        let list = lists[indexPath.section][indexPath.row]
        cell.textLabel?.text = list.key
        cell.detailTextLabel?.text = list.value
        return cell
    }
    
    // MARK: - User Methods
    func refreshData() {
        lists.removeAll()
        pasteBoard.items.forEach { (pasteItem) in
            var listGroup:[(key:String, value:String)] = []
            for key in pasteItem.keys {
                var value = ""
                if let str = pasteItem[key] as? String {
                    value = str
                } else if let date = pasteItem[key] as? Date{
                    value = date.shortDateString + date.shortTimeString
                } else {
                    value = pasteItem[key].debugDescription
                }
                listGroup.append((key: key, value: value ))

            }
            self.lists.append(listGroup)
        }
    }
    @objc func changePasteBoardContent() {
        pasteBoard.setItems([[
            "public.text" : Date().shortTimeString,
            "public.utf8-plain-text": Date().shortTimeString
            ]], options: [:])

        refreshData()
        tableView.reloadData()
    }
}
