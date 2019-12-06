//
//  ContentType.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/5.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

enum ContentType: String {
    case json = "application/json"
    case url = "application/x-www-form-urlencoded; charset=utf-8"
}

extension ContentType {
    
    var headerAdapter: AnyAdapter {
        return AnyAdapter { req in
            var req = req
            req.setValue(self.rawValue, forHTTPHeaderField: "content-type")
            
            return req
        }
    }
    
    func dataAdapter(for parameters: [String: Any]) -> RequestAdapter {
        switch self {
        case .json:
            return JSONRequestDataAdapter(data: parameters)
        case .url:
            return URLRequestDataAdapter(data: parameters)
        }
    }
    
}
