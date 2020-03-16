//
//  Extenstions.swift
//  CustomisedViews
//
//  Created by Kyle on 2020/3/5.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import Foundation

// MARK: - Extension

extension Date {
    
    var longDateString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        dateFormatter.locale = Locale(identifier: "zh_CN")
        return dateFormatter.string(from: self)
    }
    
    var shortDateString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd"
        dateFormatter.locale = Locale(identifier: "zh_CN")
        return dateFormatter.string(from: self)
    }
    
    var shortTimeString : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "zh_CN")
        return dateFormatter.string(from: self)
    }
}

