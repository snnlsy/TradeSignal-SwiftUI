//
//  BaseGetRequest.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 19.08.2024.
//

import Foundation

protocol BaseGetRequest: URLRequestable {}

extension BaseGetRequest {
    var baseURL: URL {
        URL(string: "http://127.0.0.1:5000")!
    }
    
    var method: HTTPMethod {
        .get
    }
}
