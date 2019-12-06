//
//  DecisionAction.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/6.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

enum DecisionAction<Req: HTTPRequest> {
    case continueWith(Data, HTTPURLResponse)
    case restartWith([Decision])
    case errored(Error)
    case done(Req.Response)
}
