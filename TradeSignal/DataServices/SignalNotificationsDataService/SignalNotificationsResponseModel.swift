//
//  SignalNotificationsResponseModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 3.09.2024.
//

// MARK: - SignalNotificationsResponseModel

struct SignalNotificationsResponseModel: Codable, Hashable {
    let signalNotificationsList: [SignalNotificationsModel]
}
