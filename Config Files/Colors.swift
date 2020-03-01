//
//  Colors.swift
//  CustomisedViews
//
//  Created by Kyle on 2020/2/29.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import UIKit

struct Colors {
    @available(iOS 13.0, *)
    public static var navigationBarTintColor = UIColor { (trait) -> UIColor in
        if trait.userInterfaceStyle == .light {
            return UIColor.black
        } else {
            return UIColor.white
        }
    }
}
