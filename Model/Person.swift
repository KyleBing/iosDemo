//
//  Person.swift
//  CustomisedViews
//
//  Created by Kyle on 2020/3/2.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import Foundation


struct Person: Codable {
    var id: String
    var name: String
    var nameEn: String
    var nickName: String
    var perk: String
    var motto: String
    var health: String
    var sanity: String
    var hunger: String
    var version: String
    var pic: String
    // TODO: Implment Codable
        enum CodingKeys: String, CodingKey {
        case nameEn = "name_en"
        case nickName = "nick_name"
            case id
            case name
            case perk
            case motto
            case health
            case sanity
            case hunger
            case version
            case pic
        }
}
