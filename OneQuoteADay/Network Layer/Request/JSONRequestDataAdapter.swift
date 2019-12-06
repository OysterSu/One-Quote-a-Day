//
//  JSONRequestDataAdapter.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct JSONRequestDataAdapter: RequestAdapter {
    let data: [String: Any]
    
    func adapted(_ request: URLRequest) throws -> URLRequest {
        var request = request
        request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
        
        return request
    }
}
