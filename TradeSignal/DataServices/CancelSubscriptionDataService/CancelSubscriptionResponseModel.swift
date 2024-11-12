//
//  CancelSubscriptionResponseModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 5.09.2024.
//

// MARK: - CancelSubscriptionResponseModel

struct CancelSubscriptionResponseModel: Codable, Hashable {
    let subscriptionList: [SubscriptionsModel]
}
