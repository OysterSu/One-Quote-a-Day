//
//  HTTPRequest.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/3.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

enum requestMethod: String {
    case get = "GET"
    case post = "POST"
}

struct HTTPRequest {
    let url: URL
    let method: requestMethod
    let parameters: [String: Any]?
    let header: [String: String]
    
    func buildRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        if let parameters = parameters {
            request.httpBody = parameters.map{"\($0.key)=\($0.value)"}.joined(separator: "&").data(using: .utf8)
        }
        request.allHTTPHeaderFields = header
        
        
        return request
    }
}
