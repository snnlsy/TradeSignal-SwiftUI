//
//  SignalEntity.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

import Foundation

struct SignalEntity: Hashable {
    let signalId: String
    let traderId: String
    let signalName: String
    let traderName: String
}
