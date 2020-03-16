//
//  BannerVC.swift
//  iosDemo
//
//  Created by Kyle on 2017/8/12.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class BannerVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let bannerArray = ["First", "Second", "Third"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height/2)
        
        //  CollectionView Layout
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
        layout.scrollDirection = .horizontal
        
        collectionView.collectionViewLayout = layout
    }
    
    //  MARK: - Delegete
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannerCell", for: indexPath)
        (cell.viewWithTag(100) as! UILabel).text = indexPath.row.description
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArray.count
    }

}
