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
    var header: HTTPHeader { get }
    var parameters: [String: Any] { get }
    
    var adapters: [RequestAdapter] { get }
    var decisions: [Decision] { get }
}

extension HTTPRequest {
    var adapters: [RequestAdapter] {
        return [
            method.adapter,
            header.adapter,
            RequestContentAdapter(method: method, contentType: contentType, parameters: parameters)
        ]
    }
    
    var decisions: [Decision] {[
        BadResponseDecision(),
        DataMappingDecision(
            condition: { $0.isEmpty },
            transform: { _ in "{}".data(using: .utf8)! }
        ),
        ParseResultDecision()
    ]}
    
    func buildRequest() throws -> URLRequest {
        let request = URLRequest(url: url)
        return try adapters.reduce(request) { try $1.adapted($0) }
    }
}
