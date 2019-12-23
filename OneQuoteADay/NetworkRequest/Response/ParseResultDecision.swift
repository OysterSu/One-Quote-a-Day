//
//  ParseResultDecision.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct ParseResultDecision: Decision {
    func shouldApply<Req: HTTPRequest>(request: Req, data: Data, response: HTTPURLResponse) -> Bool {
        return true
    }

    func apply<Req: HTTPRequest>(
        request: Req,
        data: Data,
        response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
    {
        do {
            let decoder = JSONDecoder()
            // Debug 用
//            let json = try? JSONSerialization.jsonObject(with: data, options: [])
//            guard let dict = json as? [String: Any] else { return }
//            print(dict)
            let value = try decoder.decode(Req.Response.self, from: data)
            closure(.done(value))
        } catch {
            closure(.errored(error))
        }
    }
}
