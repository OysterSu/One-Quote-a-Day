//
//  BadResponseDecision.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

enum ResponseError: Error {
    case nilData
    case nonHTTPResponse
    case tokenError
    case apiError(error: APIError, statusCode: Int)
}

struct APIError: Decodable {
    let code: Int
    let reason: String
}

struct BadResponseDecision: Decision {
    func shouldApply<Req: HTTPRequest>(request: Req, data: Data, response: HTTPURLResponse) -> Bool {
        return !(200..<300).contains(response.statusCode)
    }

    func apply<Req: HTTPRequest>(
        request: Req,
        data: Data,
        response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
    {
        do {
            let decoder = JSONDecoder()
            let value = try decoder.decode(APIError.self, from: data)
            closure(.errored(ResponseError.apiError(error: value, statusCode: response.statusCode)))
        } catch {
            closure(.errored(error))
        }
    }
}
