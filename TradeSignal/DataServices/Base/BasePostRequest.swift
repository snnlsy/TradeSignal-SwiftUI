//
//  BasePostRequest.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 20.08.2024.
//

import Foundation

protocol BasePostRequest: URLRequestable {}

extension BasePostRequest {
    var baseURL: URL {
        URL(string: "http://127.0.0.1:5000")!
    }
    
    var method: HTTPMethod {
        .post
    }
    
    var encoding: NetworkEncoding {
        .json
    }
}
