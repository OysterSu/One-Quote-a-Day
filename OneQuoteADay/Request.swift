//
//  Request.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/11/28.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

class Request {
    class func getQuote(callback: @escaping (Quote?, Error?) -> Void) {
        let url = URL(string: "https://good-quotes.p.rapidapi.com/random")!
        let headers = [
            "x-rapidapi-host": "good-quotes.p.rapidapi.com",
            "x-rapidapi-key": "9FKuxlfisCmshSVcxk5JMEyvdpL0p1JItHIjsncJzBcStEwLUz"
        ]
        
        let request = HTTPRequest(url: url, method: .get, parameters: nil, header: headers)
        let session = URLSession.shared
        let client = HTTPClient(session: session)
        client.send(request) { (response: HTTPResponse<Quote>?) in
            callback(response?.value, response?.error)
        }
    }
}


