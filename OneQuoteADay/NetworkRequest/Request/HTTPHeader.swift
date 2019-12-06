//
//  HTTPHeader.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct HTTPHeader {
    
    let headers: [String: String]
    
    var adapter: AnyAdapter {
        return AnyAdapter { req in
            var req = req
            for (key, value) in self.headers {
                req.addValue(value, forHTTPHeaderField: key)
            }
            
            return req
    }}
}
