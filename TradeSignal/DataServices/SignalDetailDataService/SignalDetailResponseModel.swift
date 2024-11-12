//
//  SignalDetailResponseModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.08.2024.
//

// MARK: - SignalDetailResponseModel

struct SignalDetailResponseModel: Codable, Hashable {
    let chart: [StockChartModel]
    let info: [SignalDetailInfoListModel]
}

struct SignalDetailInfoListModel: Codable, Hashable {
    let title: String
    let infoMap: [String: String]
}
