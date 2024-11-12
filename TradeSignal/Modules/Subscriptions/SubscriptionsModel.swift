//
//  SubscriptionsModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

struct SubscriptionsModel: Codable, Hashable {
    let signalId: String
    let traderName: String
    let signalName: String
    let startDate: String
    let endDate: String?
    let status: SubscriptionsStatusType
}
