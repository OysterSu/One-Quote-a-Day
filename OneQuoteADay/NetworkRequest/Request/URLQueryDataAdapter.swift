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
        var request = request
        var urlString = request.url!.absoluteString
        urlString.append("?")
        
        var parms = data.compactMap { "\($0.key)=\($0.value)" }.joined(separator: "&")
        parms = parms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        urlString.append(contentsOf: parms)
        request.url = URL(string: urlString)
        
        return request
    }
}
