//
//  CollectionViewController.swift
//  CustomisedViews
//
//  Created by Kyle on 2017/6/9.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit
import UserNotifications

private let reuseIdentifier = "CollectionViewCell"

class CollectionViewController: UICollectionViewController {

    override func viewDidLoad() {
        let space: CGFloat = 1
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        super.viewDidLoad()
        let flow = self.collectionView?.collectionViewLayout as? UICollectionViewFlowLayout
        flow?.sectionInset = insets
        let cellWidth = ((view.frame.width - 3 * space - insets.left - insets.right ) / 4 ).rounded(.down)
        flow?.itemSize = CGSize(width: cellWidth, height: 100)
        flow?.minimumLineSpacing = space
        flow?.minimumInteritemSpacing = 1
        
    }



    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        (cell.viewWithTag(100) as? UILabel)?.text = String(indexPath.row)
        
        cell.clipsToBounds = false
        
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 1
        cell.layer.shadowColor = UIColor.black.withAlphaComponent(0.1).cgColor
        cell.layer.shadowPath = CGPath(ellipseIn: CGRect(x: 10, y: 80, width: cell.frame.width-20, height: 20), transform: nil)

        return cell
    }

    // MARK: UICollectionViewDelegate
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 1 / UIScreen.main.scale
        collectionView.cellForItem(at: indexPath)?.layer.borderColor = UIColor.blue.cgColor
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.layer.borderWidth = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexPath = collectionView?.indexPath(for: (sender as! UICollectionViewCell))
        if segue.identifier! == "ShowNumber" {
            (segue.destination.view.viewWithTag(100) as? UILabel)?.text = indexPath?.row.description
        }
        
    }
}
