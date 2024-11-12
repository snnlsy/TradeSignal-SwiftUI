//
//  SignalCardModel.swift
//  TradeSignal
//
//  Created by SUlusoy on 30.06.2024.
//

struct SignalCardModel: Codable, Hashable {
    let traderID: String
    let signalID: String
    let traderName: String
    let signalName: String
    let price: Double
    let signalProperties: SignalCardPropertiesModel
    let signalPropertyIcons: SignalCardPropertyIconsModel
}
