//
//  StackViewVC.swift
//  iosDemo
//
//  Created by Kyle on 2017/6/14.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit
import UserNotifications

class StackViewVC: UIViewController {

    @IBOutlet weak var contentStackView: UIStackView!
    
    @IBAction func increaceBtnPressed(_ sender: UIButton) {
        addCircle()
    }
    @IBAction func decreaceBtnPressed(_ sender: UIButton) {
        removeCircle()
    }
    
    var index = 0
    
    func addCircle() {
        let circle = CGPath(ellipseIn: CGRect(x: 0, y: 0, width: 50, height: 50), transform: nil)
        let circleView = UIView()
        let caLayer = CAShapeLayer()
        caLayer.path = circle
        caLayer.fillColor = UIColor.orange.withAlphaComponent(0.4).cgColor
        caLayer.strokeColor = UIColor.lightGray.cgColor
        caLayer.zPosition = -1
        circleView.layer.addSublayer(caLayer)
        let indexLabel = UILabel(frame: circleView.frame)
        indexLabel.textColor = UIColor.darkGray
        indexLabel.text = "\(index)"
        indexLabel.font = UIFont.boldSystemFont(ofSize: 13)
        circleView.addSubview(indexLabel)
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.isOpaque = false
        circleView.alpha = 0
        self.contentStackView.addArrangedSubview(circleView)
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.3, delay: 0, options: [], animations: {
            circleView.alpha = 1
        }, completion: nil)
        
        index+=1
    }
    
    func removeCircle() {
        if !contentStackView.subviews.isEmpty {
            contentStackView.subviews.last?.removeFromSuperview()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
