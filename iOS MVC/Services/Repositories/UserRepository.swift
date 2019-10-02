//
//  UserRepository.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import ObjectMapper

protocol UserRepositoryType {
    func searchUsers(keyword: String, limit: Int, completion: @escaping (BaseResult<SearchResponse>?) -> Void)
}

class UserRepository: UserRepositoryType {
    
    private var api: APIService
    
    required init(api: APIService) {
        self.api = api
    }
    
    func searchUsers(keyword: String, limit: Int, completion: @escaping (BaseResult<SearchResponse>?) -> Void) {
        let input = SearchRequest(keyword: keyword, limit: limit)
        
        api.request(input: input) { (object: SearchResponse?, error) in
            if let object = object {
                completion(.success(object))
            } else if let error = error {
                completion(.failure(error: error))
            } else {
                completion(nil)
            }
        }
    }
    
}
