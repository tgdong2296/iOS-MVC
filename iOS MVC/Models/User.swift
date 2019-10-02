//
//  User.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper
import Then

struct User {
    var id = 0
    var name = ""
    var avatarUrl = ""
    var type = ""
}

extension User: Then { }

extension User: BaseModel {
    
    init?(map: Map) {
        self.init()
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["login"]
        avatarUrl <- map["avatar_url"]
        type <- map["type"]
    }
}
