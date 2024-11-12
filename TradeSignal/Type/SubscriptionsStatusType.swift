//
//  SubscriptionsStatusType.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

// MARK: - SubscriptionsStatusType

enum SubscriptionsStatusType: String, Codable {
    case active = "active"
    case pending = "pending"
    case expired = "expired"
}
