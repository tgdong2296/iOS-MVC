//
//  CustomRequestAdapter.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire

class CustomRequestAdapter: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
}
