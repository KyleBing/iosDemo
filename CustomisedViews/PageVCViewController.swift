//
//  PageVCViewController.swift
//  iosDemo
//
//  Created by Kyle on 2017/6/19.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class PageVCViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate{

    let count = 20
    var vcCells: [UIViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
        
        for i in 1...count {
            let dest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageVCCell")
            (dest.view.viewWithTag(100) as? UILabel)?.text = i.description
            vcCells.append(dest)
        }
        
        let animationVC = AnimationDymanicVC()
        let viewAnimationVC = AnimationVC()
        vcCells.insert(viewAnimationVC, at: 0)
        vcCells.insert(animationVC, at: 0)
        
        view.backgroundColor = UIColor.gray
        setViewControllers([vcCells[0]], direction: .reverse, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = vcCells.firstIndex(of: viewController)
        if index! > 0 {
            return vcCells[index!-1]
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = vcCells.firstIndex(of: viewController)
        if index! < vcCells.count-1 {
            return vcCells[index!+1]
        } else {
            return nil
        }
    }
    
}
