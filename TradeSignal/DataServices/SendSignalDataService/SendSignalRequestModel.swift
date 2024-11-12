//
//  SendSignalRequestModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

// MARK: - SendSignalRequestModel

struct SendSignalRequestModel: BasePostRequest {
    var path: String = "/sendsignal"
    var parameters: Encodable?

    init(parameters: SendSignalRequestParameters) {
        self.parameters = parameters
    }
}

// MARK: - SendSignalRequestParameters

struct SendSignalRequestParameters: Encodable {
    let signalId: String
    let stopLoss: Double
    let tradeType: TradeType
}
