//
//  WindowViewsVC.swift
//  iosDemo
//
//  Created by Kyle on 2017-11-21.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class WindowViewsVC: UIViewController {

    @IBAction func showInfoButtonPressed(_ sender: UIButton) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window = appDelegate.window
        
        if let rootVC = window?.rootViewController as? UINavigationController {
            print(rootVC.children.debugDescription)
            print(rootVC.visibleViewController.debugDescription)
        }
    }

    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        dismiss(animated: true) {
            
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

}
