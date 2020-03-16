//
//  ButtonStageVC.swift
//  iosDemo
//
//  Created by Kyle on 2017-11-14.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class ButtonStageVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animatedButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addButtonPressed))
        navigationItem.rightBarButtonItem = animatedButton
        
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        button.backgroundColor = UIColor.black.withAlphaComponent(0.05)
        button.clipsToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1 / UIScreen.main.scale
        button.layer.borderColor = UIColor.lightGray.cgColor
        
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .highlighted)
        button.setTitle("正常", for: UIControl.State.normal)
        button.setTitle("高亮中", for: UIControl.State.highlighted)
        view.addSubview(button)
        
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 100).isActive = true
        button.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        button.addTarget(self, action: #selector(buttonPressed(btn:)), for: UIControl.Event.touchUpInside)
    }
    
    
    @objc func buttonPressed (btn: UIButton) {
        if let tipLabel = view.viewWithTag(100) {
            // add flip animation to tipLabel
            UIView.transition(with: tipLabel, duration: 0.5, options: [.transitionFlipFromTop], animations: {
                tipLabel.alpha = tipLabel.alpha == 0 ? 1 : 0
            }, completion: nil)
        } else {
            let tip = UILabel()
            tip.isOpaque = false
            tip.tag = 100
            tip.textAlignment = .center
            tip.backgroundColor = UIColor.black.withAlphaComponent(0.05)
            
            tip.layer.cornerRadius = 5
            tip.layer.borderWidth = 1 / UIScreen.main.scale
            tip.layer.borderColor = UIColor.lightGray.cgColor
            
            tip.translatesAutoresizingMaskIntoConstraints = false
            tip.text = "This is a button"
            view.addSubview(tip)
            
            NSLayoutConstraint.activate([
                tip.centerXAnchor.constraint(equalTo: btn.centerXAnchor),
                tip.bottomAnchor.constraint(equalTo: btn.topAnchor, constant: -20),
                tip.widthAnchor.constraint(equalToConstant: 200),
                tip.heightAnchor.constraint(equalToConstant: 50)
                ])
        }
    }

    @objc func addButtonPressed () {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: [], animations: {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.action, target: self, action: #selector(self.actionButtonPressed))
        }, completion: nil)
    }
    
    @objc func actionButtonPressed () {
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 1, delay: 0, options: [], animations: {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(self.addButtonPressed))
        }, completion: nil)
    }
    

}
