//
//  CustomisedVC.swift
//  CustomisedViews
//
//  Created by Kyle on 2017-11-21.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class CustomisedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let window = appDelegate.window
        
        if let rootVC = window?.rootViewController as? UINavigationController{
            print(rootVC.children.debugDescription)
            print(rootVC.visibleViewController.debugDescription)
        }
    }
    
    
    @IBAction func showCustomPressed(_ sender: UIButton) {
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = view.frame
        view.addSubview(blurView)
        
        let buttonPanel = UIView()
        view.addSubview(buttonPanel)
        buttonPanel.translatesAutoresizingMaskIntoConstraints = false
        buttonPanel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        buttonPanel.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        buttonPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let dummyButton1 = UIButton()
        dummyButton1.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        dummyButton1.translatesAutoresizingMaskIntoConstraints = false
        dummyButton1.setTitle("Dummy Button", for: UIControl.State.normal)
        dummyButton1.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        dummyButton1.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        dummyButton1.titleLabel!.textAlignment = .center
        dummyButton1.titleLabel!.font = UIFont.systemFont(ofSize: 24)
        
        let dummyButton2 = UIButton()
        dummyButton2.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        dummyButton2.translatesAutoresizingMaskIntoConstraints = false
        dummyButton2.setTitle("Dummy Button", for: UIControl.State.normal)
        dummyButton2.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        dummyButton2.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        dummyButton2.titleLabel!.textAlignment = .center
        dummyButton2.titleLabel!.font = UIFont.systemFont(ofSize: 24)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        
        stackView.addArrangedSubview(dummyButton1)
        stackView.addArrangedSubview(dummyButton2)

        buttonPanel.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: buttonPanel.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: buttonPanel.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: buttonPanel.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: buttonPanel.bottomAnchor).isActive = true
        
        
        
    }
}
