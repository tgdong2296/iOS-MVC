//
//  SearchRequest.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire

final class SearchRequest: BaseRequest {
    
    required init(keyword: String, limit: Int) {
        let body: [String: Any]  = [
            "per_page": limit,
            "q": keyword
        ]
        super.init(url: URLs.searchUser, requestType: .get, body: body)
    }
    
}
