//
//  SignalCardPropertiesModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 1.06.2024.
//

// MARK: - SignalPropertiesModel

struct SignalCardPropertiesModel: Codable, Hashable {
    let gainRate: Double
    let subscriberCount: Int
    let marketType: MarketType
    let termType: TermType
}
