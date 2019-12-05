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
    var contentType: ContentType { get }
    var header: [String: String] { get }
    var parameters: [String: Any] { get }
    
    var adapters: [RequestAdapter] { get }
}

extension HTTPRequest {
    var adapters: [RequestAdapter] {
        return [
            method.adapter,
            RequestContentAdapter(method: method, contentType: contentType, header: header, parameters: parameters)
        ]
    }
    
    func buildRequest() throws -> URLRequest {
        let request = URLRequest(url: url)
        return try adapters.reduce(request) { try $1.adapted($0) }
    }
}
