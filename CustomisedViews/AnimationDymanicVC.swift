//
//  AnimationDymanicVC.swift
//  CustomisedViews
//
//  Created by Kyle on 2020/3/1.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import UIKit

class AnimationDymanicVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func createBallView() -> UIView {
        let ballView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 50, height: 50)))
        return ballView
    }

}
