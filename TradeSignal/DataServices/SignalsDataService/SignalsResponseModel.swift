//
//  SignalsResponseModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 20.08.2024.
//

// MARK: - SignalsResponseModel

struct SignalsResponseModel: Codable, Hashable {
    let signalCardList: [SignalCardModel]
    let signalPropertyIcons: SignalCardPropertyIconsModel
}
