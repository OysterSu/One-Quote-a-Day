//
//  HTTPRequest.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/3.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

protocol HTTPRequest {
    associatedtype Response: Decodable
    
    var url: URL { get }
    var method: HTTPMethod { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension HTTPRequest {
    func buildRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header
        if let parameters = parameters {
            request.httpBody = parameters.map{"\($0.key)=\($0.value)"}.joined(separator: "&").data(using: .utf8)
        }
        
        return request
    }
}
