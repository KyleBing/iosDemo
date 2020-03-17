//
//  CustomizedVC.swift
//  iosDemo
//
//  Created by Kyle on 2017-11-21.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

// MARK: - Constrain 创建对齐约束有两种方式
   /// Creating a constraint using NSLayoutConstraint
   /// NSLayoutConstraint(item: button,
   ///                   attribute: .Width,
   ///                   relatedBy: .GreaterThanOrEqual,
   ///                   toItem: button,
   ///                   attribute: .Height,
   ///                   multiplier: 2.0,
   ///                   constant: 40.0).active = true

   /// Creating the same constraint using constraintGreaterThanOrEqualToAnchor:multiplier:constant:
   /// button.widthAnchor.constraintGreaterThanOrEqualToAnchor(button.heightAnchor, multiplier: 2.0, constant: 40.0).active = true
   

import UIKit

class CustomizedVC: UIViewController {
    var safeBottom: CGFloat {
        if #available(iOS 11.0, *) {
            return view.safeAreaInsets.bottom
        } else {
            return 0
        }
    }
    
    // view tags
    let tagOfBlurView = 10
    let tagOfButtonPanel = 20
    
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
        blurView.tag = tagOfBlurView
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = view.frame
        view.addSubview(blurView)
        
        let buttonPanel = UIView()
        buttonPanel.tag = tagOfButtonPanel
        view.addSubview(buttonPanel) // 先添加 view 到父元素才能设置 constrain

        // 自动对齐的那一套
        buttonPanel.translatesAutoresizingMaskIntoConstraints = false
        buttonPanel.heightAnchor.constraint(equalToConstant: 120).isActive = true
        buttonPanel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -safeBottom).isActive = true
        buttonPanel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        buttonPanel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        let dummyButton1 = UIButton()
        dummyButton1.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        dummyButton1.translatesAutoresizingMaskIntoConstraints = false
        dummyButton1.setTitle("Recovery", for: UIControl.State.normal)
        dummyButton1.setTitleColor(UIColor.darkGray, for: UIControl.State.normal)
        dummyButton1.setTitleColor(UIColor.lightGray, for: UIControl.State.highlighted)
        dummyButton1.titleLabel!.textAlignment = .center
        dummyButton1.titleLabel!.font = UIFont.systemFont(ofSize: 24)
        
        dummyButton1.addTarget(self, action: #selector(removeBlurAndButtons), for: .touchUpInside) // 添加点击事件
        
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
    
    @objc func removeBlurAndButtons(){
        let buttonPanelView = view.viewWithTag(tagOfButtonPanel)
        let blurView = view.viewWithTag(tagOfBlurView)
        blurView?.removeFromSuperview()
        buttonPanelView?.removeFromSuperview()
    }
}
