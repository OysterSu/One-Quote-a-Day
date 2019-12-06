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
    
    func send<req: HTTPRequest>(_ request: req, decisions: [Decision]? = nil, handler: @escaping (Result<req.Response, Error>) -> Void) {
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
            
            guard let response = response as? HTTPURLResponse else {
                handler(.failure(ResponseError.nonHTTPResponse))
                return
            }
            
            self.handleDecisions(decisions ?? request.decisions, request: request, data: data, response: response) { (response: Result<req.Response, Error>) in
                switch response {
                case .success(let value):
                    handler(.success(value))
                case .failure(let error):
                    handler(.failure(error))
                }
            }
        }
        
        task.resume()
    }
    
    private func handleDecisions<Req: HTTPRequest>(
        _ decisions: [Decision],
        request: Req,
        data: Data,
        response: HTTPURLResponse,
        handler: @escaping (Result<Req.Response, Error>) -> Void)
    {
        guard !decisions.isEmpty else {
            fatalError("No decision left but did not reach a stop.")
        }

        var decisions = decisions
        let current = decisions.removeFirst()

        guard current.shouldApply(request: request, data: data, response: response) else {
            handleDecisions(decisions, request: request, data: data, response: response, handler: handler)
            return
        }

        current.apply(request: request, data: data, response: response) { action in
            switch action {
            case .continueWith(let data, let response):
                self.handleDecisions(decisions, request: request, data: data, response: response, handler: handler)

            case .restartWith(let decisions):
                self.send(request, decisions: decisions, handler: handler)
                
            case .errored(let error):
                handler(.failure(error))
                
            case .done(let value):
                handler(.success(value))
            }
        }
    }
}
