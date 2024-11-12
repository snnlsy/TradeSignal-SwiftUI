//
//  SubscriptionsResponseModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

// MARK: - SubscriptionsResponseModel

struct SubscriptionsResponseModel: Codable, Hashable {
    let subscriptionList: [SubscriptionsModel]
}
