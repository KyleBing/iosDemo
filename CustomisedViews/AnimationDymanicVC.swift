//
//  AnimationDymanicVC.swift
//  iosDemo
//
//  Created by Kyle on 2020/3/1.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import UIKit

class AnimationDymanicVC: UIViewController {
    
    // 1. create Animator
    lazy var animator = UIDynamicAnimator(referenceView: view)
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let ballView = view.viewWithTag(100)!
        ballView.center = CGPoint(x: view.bounds.midX, y: 30)
        animator.updateItem(usingCurrentState: ballView) // 当旋转屏幕的时候，更新元素位置
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAnimation()
        let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(pushBall))
        self.view.addGestureRecognizer(tapGuesture)
    }
    
    @objc func pushBall() {
        let ballView = view.viewWithTag(100)!
        let pushBehavior = UIPushBehavior(items: [ballView], mode: .instantaneous)
        pushBehavior.pushDirection = CGVector(dx: CGFloat.random(in: -0.5...0.5), dy: -1)
        pushBehavior.magnitude = 5
        pushBehavior.action = { [unowned pushBehavior] in // delete after fire it
            pushBehavior.dynamicAnimator?.removeBehavior(pushBehavior)
        }
        animator.addBehavior(pushBehavior)
        pushBehavior.addItem(ballView)
    }
    
    func addAnimation() {
        let ballView = BallView(frame: CGRect(origin: CGPoint(x: view.bounds.midX, y: 0), size: CGSize(width: 60, height: 60)))
        ballView.isOpaque = false
        ballView.tag = 100
        view.addSubview(ballView)
        // 2. create behavior
        let gravityBehavior = UIGravityBehavior()
        // 3. add behavior to animator
        animator.addBehavior(gravityBehavior)
        // 4.add item to behavior
        /// UIDynamicItem 是个 protocol， UIView 已经实现了这个 protocol
        gravityBehavior.addItem(ballView)
        /// 当 item 添加到 Animator的时候，这个元素属于 Animator，如何你想更新这个元素，需要调用这个方法
        /// animator.updateItem(usingCurrentState: UIDynamicItem)
        
        let collisinoBehavior = UICollisionBehavior()
        // 定义 collistionBehavior 边界为容器的边界
        collisinoBehavior.translatesReferenceBoundsIntoBoundary = true
        /// 或者定义任意 Path 为边界
        /*
        if #available(iOS 11.0, *) {
            let boundrayRect = CGRect(x: 10, y: 10, width: view.frame.maxX - 10, height: view.frame.maxY - 10)
            collisinoBehavior.addBoundary(withIdentifier: "outline" as NSCopying,
                                          for: UIBezierPath(ovalIn: boundrayRect))
        }
         */
        collisinoBehavior.addItem(ballView)
        animator.addBehavior(collisinoBehavior)
    }
}



class BallView: UIView {
    override func draw(_ rect: CGRect) {
        let lineWidth: CGFloat = 1
        let rect = CGRect(x: lineWidth, y: lineWidth, width: rect.maxX - 2 * lineWidth, height: rect.maxY - 2 * lineWidth)
        let path = UIBezierPath(ovalIn: rect)
        path.lineWidth = lineWidth
        UIColor.orange.setFill()
        UIColor.yellow.setStroke()
        path.stroke()
        path.fill()
    }
}
