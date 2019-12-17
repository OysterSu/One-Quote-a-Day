//
//  RequestContentAdapter.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/5.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct RequestContentAdapter: RequestAdapter {
    
    let method: HTTPMethod
    let contentType: ContentType
    let parameters: [String: Any]

    func adapted(_ request: URLRequest) throws -> URLRequest {
        switch method {
        case .GET:
            return URLQueryDataAdapter(data: parameters).adapted(request)
        case .POST:
            var req = request
            
            // Header
            let headerAdapter = contentType.headerAdapter
            req = try headerAdapter.adapted(req)
            
            // Body
            let dataAdapter = contentType.dataAdapter(for: parameters)
            req = try dataAdapter.adapted(req)
            
            return req
        }
    }
}
