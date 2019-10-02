//
//  SearchResponse.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

final class SearchResponse : Mappable {
    
    var totalCount = 0
    var users = [User]()
    
    required init(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        totalCount <- map["total_count"]
        users <- map["items"]
    }
}
