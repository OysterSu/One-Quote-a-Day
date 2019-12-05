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
            req.setValue(self.rawValue, forHTTPHeaderField: "Content-Type")
            return req
        }
    }
    
    func dataAdapter(for parameters: [String: Any]) -> RequestAdapter {
        switch self {
        case .url:
            return URLQueryDataAdapter(data: parameters)
        case .json:
            return JSONRequestDataAdapter(data: parameters)

        }
    }
}

struct URLQueryDataAdapter: RequestAdapter {
    let data: [String: Any]
    
    func adapted(_ request: URLRequest) -> URLRequest {
        var request = request
        for (key, value) in data as! [String: String] {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}

struct JSONRequestDataAdapter: RequestAdapter {
    let data: [String: Any]
    
    func adapted(_ request: URLRequest) throws -> URLRequest {
        var request = request
        request.httpBody = try JSONSerialization.data(withJSONObject: data, options: [])
        
        return request
    }
}
