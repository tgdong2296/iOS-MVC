//
//  APIService.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/1/19.
//  Copyright © 2019 demo. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

struct APIService {
    
    static let shared = APIService()
    
    private var alamofireManager = Alamofire.SessionManager.default
    
    init() {
        let configuration = URLSessionConfiguration.default.then {
            $0.timeoutIntervalForRequest = 30
            $0.timeoutIntervalForResource = 30
        }
        alamofireManager = Alamofire.SessionManager(configuration: configuration)
        alamofireManager.adapter = CustomRequestAdapter()
    }
    
    func request<T: Mappable>(input: BaseRequest, completion: @escaping (_ value: T?,_ error: Error?) -> Void) {
        
        print("🌎 [Request] \(input.url), [Body] \(String(describing: input.body))")
        
        alamofireManager.request(input.url, method: input.requestType, parameters: input.body, encoding: input.encoding)
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let object = Mapper<T>().map(JSONObject: value)
                    completion(object, nil)
                    print("🌈 [Success] \(input.url))")

                case .failure(let error):
                    print("❌ [Error] \(input.url): \(error))")
                    completion(nil, error)
                }
            }
    }
    
}
