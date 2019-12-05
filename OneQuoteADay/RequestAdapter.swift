//
//  RequestAdapter.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/5.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

protocol RequestAdapter {
    func adapted(_ request: URLRequest) throws -> URLRequest
}

struct AnyAdapter: RequestAdapter {
    let block: (URLRequest) throws -> URLRequest
    
    func adapted(_ request: URLRequest) throws -> URLRequest {
        return try block(request)
    }
}
