//
//  SignalNotificationsRequestModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 3.09.2024.
//

import Foundation

// MARK: - SignalNotificationsRequestModel

struct SignalNotificationsRequestModel: BasePostRequest {
    var path: String = "/signalnotifications"
    var parameters: Encodable?

    init(parameters: SignalNotificationsRequestParameters) {
        self.parameters = parameters
    }
}

// MARK: - SignalNotificationsRequestParameters

struct SignalNotificationsRequestParameters: Encodable {
    let signalId: String
}
