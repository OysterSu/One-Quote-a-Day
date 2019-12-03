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

protocol HTTPRequest {
    associatedtype Response: Decodable
    
    var url: URL { get }
    var method: String { get }
    var header: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension HTTPRequest {
    func buildRequest() -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = header
        if let parameters = parameters {
            request.httpBody = parameters.map{"\($0.key)=\($0.value)"}.joined(separator: "&").data(using: .utf8)
        }
        
        return request
    }
}
