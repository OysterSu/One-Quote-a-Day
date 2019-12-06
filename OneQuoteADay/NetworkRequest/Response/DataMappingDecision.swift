//
//  DataMappingDecision.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct DataMappingDecision: Decision {

    let condition: (Data) -> Bool
    let transform: (Data) -> Data

    init(condition: @escaping ((Data) -> Bool), transform: @escaping (Data) -> Data) {
        self.transform = transform
        self.condition = condition
    }

    func shouldApply<Req: HTTPRequest>(request: Req, data: Data, response: HTTPURLResponse) -> Bool {
        return condition(data)
    }

    func apply<Req: HTTPRequest>(
        request: Req,
        data: Data, response: HTTPURLResponse,
        done closure: @escaping (DecisionAction<Req>) -> Void)
    {
        closure(.continueWith(transform(data), response))
    }
}
