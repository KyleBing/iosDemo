//
//  PageViewCell.swift
//  CustomisedViews
//
//  Created by Kyle on 2017/6/19.
//  Copyright © 2017年 KyleBing. All rights reserved.
//

import UIKit

class PageViewCell: UIViewController {

    @IBOutlet weak var label: UILabel!
    
    var labelText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = labelText
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
