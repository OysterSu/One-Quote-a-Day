//
//  URLRequestDataAdapter.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct URLRequestDataAdapter: RequestAdapter {
    let data: [String: Any]
    
    func adapted(_ request: URLRequest) throws -> URLRequest {
        var request = request
        request.httpBody = data.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)
        
        return request
    }
}
