//
//  HTTPClient.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/3.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct HTTPClient {
    let session: URLSession
    
    func send<T: Codable>(_ request: HTTPRequest, handler: @escaping (HTTPResponse<T>?) -> Void) {
        let urlRequest = request.buildRequest()
        let task = session.dataTask(with: urlRequest) { data, response, error in
            handler(try? HTTPResponse(data: data, response: response, error: error))
        }
        
        task.resume()
    }
}
