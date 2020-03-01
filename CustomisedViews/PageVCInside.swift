//
//  PageVCInside.swift
//  CustomisedViews
//
//  Created by Kyle on 2017/6/24.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class PageVCInside: UIViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    @IBOutlet weak var pageView: UIView!
    let count = 20
    var vcCells: [UIViewController] = []
    var pageViewController: UIPageViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get VCCELLS
        for i in 1...count {
            let dest = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageVCCell")
            dest.view.backgroundColor = UIColor.lightGray
            (dest.view.viewWithTag(100) as? UILabel)?.text = i.description
            vcCells.append(dest)
        }
        
        // Init PageVC
        pageViewController = UIPageViewController(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: nil)
        pageViewController.view.frame = pageView.bounds
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        self.addChild(pageViewController)
        pageView.addSubview(pageViewController.view)
        
        pageViewController.setViewControllers([vcCells[0]], direction: .reverse,animated: true)
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
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return vcCells.count
    }



}
