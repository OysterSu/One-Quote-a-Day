//
//  URLQueryDataAdapter.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct URLQueryDataAdapter: RequestAdapter {
    let data: [String: Any]
    
    func adapted(_ request: URLRequest) -> URLRequest {
        
        return request
    }
}
