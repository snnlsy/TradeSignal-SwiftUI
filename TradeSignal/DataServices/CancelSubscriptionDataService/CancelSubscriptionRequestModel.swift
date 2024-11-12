//
//  CancelSubscriptionRequestModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 5.09.2024.
//

// MARK: - CancelSubscriptionRequestModel

struct CancelSubscriptionRequestModel: BasePostRequest {
    var path: String = "/cancelsubscription"
    var parameters: Encodable?

    init(parameters: CancelSubscriptionRequestParameters) {
        self.parameters = parameters
    }
}

// MARK: - CancelSubscriptionRequestParameters

struct CancelSubscriptionRequestParameters: Encodable {
    let signalId: String
}
