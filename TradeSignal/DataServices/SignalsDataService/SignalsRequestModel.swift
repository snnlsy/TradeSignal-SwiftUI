//
//  SignalsRequestModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 20.08.2024.
//

// MARK: - SignalsRequestModel

struct SignalsRequestModel: BasePostRequest {
    var path: String = "/signals"
    var parameters: Encodable?

    init(parameters: SignalsRequestParameters) {
        self.parameters = parameters
    }
}

// MARK: - SignalsRequestParameters

struct SignalsRequestParameters: Encodable {
    let userId: Int
}
