//
//  HTTPMethod.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/5.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

extension HTTPMethod {
    var adapter: AnyAdapter {
        return AnyAdapter { req in
            var req = req
            req.httpMethod = self.rawValue
            
            return req
    }}
}
