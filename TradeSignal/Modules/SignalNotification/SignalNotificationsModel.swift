//
//  SignalNotificationsModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 3.09.2024.
//

struct SignalNotificationsModel: Codable, Hashable {
    let date: String
    let instruments: String
    let stopLoss: Double
}
