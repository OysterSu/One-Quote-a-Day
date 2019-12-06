//
//  ResponseDecision.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

protocol Decision {
    func shouldApply<Req: HTTPRequest>(request: Req, data: Data, response: HTTPURLResponse) -> Bool
    func apply<Req: HTTPRequest>(request: Req, data: Data, response: HTTPURLResponse, done closure: @escaping (DecisionAction<Req>) -> Void)
}
