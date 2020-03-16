//
//  CustomizedVC.swift
//  iosDemo
//
//  Created by Kyle on 2017/6/29.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class AnimationVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let baseRect = CGSize(width: 100, height: 150)
        addBox(size: baseRect, color: UIColor.orange)
        
        let buttonBasic = UIBarButtonItem(title: "basic", style: .plain, target: self, action: #selector(basicAnimation))
        let buttonHole = UIBarButtonItem(title: "hole", style: .plain, target: self, action: #selector(holeItemAnimation))

        navigationItem.rightBarButtonItems = [buttonBasic, buttonHole]
    }
    
    func addBox(size: CGSize, color: UIColor) {
        let addingView = UIView(frame: CGRect(origin: view.center, size: size))
        addingView.tag = 100
        addingView.backgroundColor = color
        view.addSubview(addingView)
    }
    
    // MARK: - Animation
    @objc func basicAnimation () {
        UIViewPropertyAnimator.runningPropertyAnimator(
            withDuration: 1,
            delay: 0,
            options: [.curveEaseInOut, .allowUserInteraction],
            animations: {
                let animatingView = self.view.viewWithTag(100)!
                animatingView.backgroundColor = UIColor.magenta
                animatingView.center = CGPoint(x: animatingView.frame.midX - 40, y: animatingView.frame.midY - 50)
        }) { (animationPosition) in
            
        }
    }
    
    @objc func holeItemAnimation () {
        let animatingView = self.view.viewWithTag(100)!
        
        UIView.transition(with: animatingView,
                          duration: 1,
                          options: .transitionFlipFromBottom,
                          animations: {
                            animatingView.backgroundColor = UIColor.orange
                            animatingView.center = CGPoint(x: animatingView.frame.midX + 40, y: animatingView.frame.midY + 50)
                           },
                          completion: nil)
    }
}
