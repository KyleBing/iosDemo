//
//  NavigationBarVC.swift
//  CustomisedViews
//
//  Created by Kyle on 2017/7/21.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class NavigationBarVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = UIColor.red
        _ = [
            UIBarButtonItem(barButtonSystemItem: .add,          target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .bookmarks,    target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .camera,       target: self, action: nil),
            UIBarButtonItem(barButtonSystemItem: .action,       target: self, action: nil)
        ]
        let buttonsWords = [
            UIBarButtonItem(title: "1", style: .plain, target: self, action: nil),
            UIBarButtonItem(title: "2", style: .plain, target: self, action: nil),
            UIBarButtonItem(title: "3", style: .plain, target: self, action: nil),
            UIBarButtonItem(title: "4", style: .plain, target: self, action: nil)
        ]
        navigationItem.rightBarButtonItems = buttonsWords
        navigationItem.prompt = "prompt"
        self.title = "Navigation"
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
