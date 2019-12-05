//
//  QuoteRequest.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/3.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct QuoteRequest: HTTPRequest {
    typealias Response = QuoteResult
    
    var url: URL
    var method: HTTPMethod
    var contentType: ContentType = .url
    var header: [String : String]
    var parameters: [String : Any] = [:]
}
