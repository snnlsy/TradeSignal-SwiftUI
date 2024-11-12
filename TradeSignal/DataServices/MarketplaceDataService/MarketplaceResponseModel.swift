//
//  MarketplaceResponseModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 8.07.2024.
//

// MARK: - MarketplaceResponseModel

struct MarketplaceResponseModel: Codable, Hashable {
    let filterOptions: [String]
    let signalCardList: [SignalCardModel]
    let signalPropertyIcons: SignalCardPropertyIconsModel
}
