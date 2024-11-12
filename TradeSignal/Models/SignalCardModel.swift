//
//  SignalCardModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 30.06.2024.
//

// MARK: - SignalCardModel

struct SignalCardModel: Codable, Hashable {
    let traderId: String
    let signalId: String
    let traderName: String
    let signalName: String
    let price: Double
    let signalProperties: SignalCardPropertiesModel
}
