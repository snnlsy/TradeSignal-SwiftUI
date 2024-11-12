//
//  SignalDetailRequestModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.08.2024.
//

// MARK: - SignalDetailRequestModel

struct SignalDetailRequestModel: BasePostRequest {
    var path: String = "/signaldetail"
    var parameters: Encodable?

    init(parameters: SignalDetailRequestParameters) {
        self.parameters = parameters
    }
}

// MARK: - SignalDetailRequestParameters

struct SignalDetailRequestParameters: Encodable {
    let signalId: Int
}

