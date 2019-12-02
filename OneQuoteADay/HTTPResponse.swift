//
//  HTTPResponse.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/3.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

let decoder = JSONDecoder()

enum ResponseError: Error {
    case nilData
}

struct HTTPResponse<T: Codable> {
    let value: T?
    let response: HTTPURLResponse?
    let error: Error?
    
    init(data: Data?, response: URLResponse?, error: Error?) throws {
        self.value = try data.map{ try decoder.decode(T.self, from: $0) }
        self.response = response as? HTTPURLResponse
        self.error = error
    }
}
