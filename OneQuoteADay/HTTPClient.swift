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
    
    func send<T: Codable>(_ request: HTTPRequest, handler: @escaping (Result<T, Error>) -> Void) {
        let urlRequest = request.buildRequest()
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                handler(.failure(error ?? ResponseError.nilData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(T.self, from: data)
                handler(.success(value))
            } catch {
                handler(.failure(error))
            }
        }
        
        task.resume()
    }
}
