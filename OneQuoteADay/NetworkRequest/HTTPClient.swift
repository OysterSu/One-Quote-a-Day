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
    
    func send<req: HTTPRequest>(_ request: req, handler: @escaping (Result<req.Response, Error>) -> Void) {
        let urlRequest: URLRequest
        do {
            urlRequest = try request.buildRequest()
        } catch {
            handler(.failure(error))
            return
        }
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            guard let data = data else {
                handler(.failure(error ?? ResponseError.nilData))
                return
            }

            do {
                let decoder = JSONDecoder()
                let value = try decoder.decode(req.Response.self, from: data)
                handler(.success(value))
            } catch {
                handler(.failure(error))
            }
        }
        
        task.resume()
    }
}
