//
//  ViewModel.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/12/3.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import Foundation

struct ViewModel {
    static func getQuote(callback: @escaping (Result<QuoteResult, Error>) -> Void) {
        let url  = URL(string: "https://quotable-quotes.p.rapidapi.com/randomQuotes")!
        let headers = [
            "x-rapidapi-host": "quotable-quotes.p.rapidapi.com",
            "x-rapidapi-key": "9FKuxlfisCmshSVcxk5JMEyvdpL0p1JItHIjsncJzBcStEwLUz"
        ]
        
        let request = QuoteRequest(url: url, method: .GET, header: HTTPHeader(headers: headers))
        let session = URLSession.shared
        let client = HTTPClient(session: session)
        
        client.send(request) { (response: Result<QuoteResult, Error>) in
            callback(response)
        }
    }
}
