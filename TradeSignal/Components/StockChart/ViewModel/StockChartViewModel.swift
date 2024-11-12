//
//  StockChartViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 27.08.2024.
//

import SwiftUI

// MARK: - StockChartViewModel

final class StockChartViewModel: ObservableObject {
    @Published private(set) var chartModelList: [StockChartModel] = []
    @Published var selectedChartModel: StockChartModel?
    @Published var animationProgress: Double = 0
    @Published var currentTab: TimeRange = .sevenDays

    enum TimeRange: String, CaseIterable, Identifiable {
        case sevenDays = "7 Days"
        case week = "Week"
        case month = "Month"
        
        var id: String { self.rawValue }
    }
    
    var averageYAxis: Double {
        chartModelList.isEmpty ? 0 : chartModelList.map(\.yAxis).reduce(0, +) / Double(chartModelList.count)
    }
    
    func updateData(stockChartModelList: [StockChartModel]) {
        chartModelList = stockChartModelList
    }

    func animateChart() {
        withAnimation(.easeInOut(duration: 0.5)) {
            animationProgress = 1.0
        }
    }

    func animatedYAxis(for chartModel: StockChartModel) -> Double {
        chartModel.yAxis * animationProgress
    }
    
    func updateData(for timeRange: TimeRange) {
        print(timeRange)
    }
}
