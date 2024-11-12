//
//  UserResponseModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.08.2024.
//

// MARK: - UserResponseModel

struct UserResponseModel: Codable, Hashable {
    let filterOptions: [String]
    let signalCardList: [SignalCardModel]
    let signalPropertyIcons: SignalCardPropertyIconsModel
}
