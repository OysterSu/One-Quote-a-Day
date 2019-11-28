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
        let headers = [
            "x-rapidapi-host": "good-quotes.p.rapidapi.com",
            "x-rapidapi-key": "9FKuxlfisCmshSVcxk5JMEyvdpL0p1JItHIjsncJzBcStEwLUz"
        ]

        let request = NSMutableURLRequest(url: NSURL(string: "https://good-quotes.p.rapidapi.com/random")! as URL,
                                                cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            guard error == nil else {
                callback(nil, error)
                return
            }
            
            guard let data = data else { return }
                        
            let decoder = JSONDecoder()
            let quote = try! decoder.decode(Quote.self, from: data)
            
            callback(quote, error)
        })

        dataTask.resume()
    }
}


