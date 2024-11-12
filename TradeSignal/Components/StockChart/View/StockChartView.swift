//
//  StockChartView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 27.08.2024.
//

import SwiftUI
import Charts

// MARK: - CoinChartView

struct CoinChartView: View {
    @ObservedObject var viewModel: StockChartViewModel

    var body: some View {
        Chart {
            ForEach(viewModel.chartModelList, id: \.self) { chartModel in
                LineMark(
                    x: .value("Date", chartModel.xAxis),
                    y: .value("Gain Rate", viewModel.animatedYAxis(for: chartModel))
                )
                .foregroundStyle(Color.theme.secondaryVariant)
                .interpolationMethod(.catmullRom)

                AreaMark(
                    x: .value("Date", chartModel.xAxis),
                    y: .value("Gain Rate", viewModel.animatedYAxis(for: chartModel))
                )
                .foregroundStyle(StockChartStyle.areaGradient)
                .interpolationMethod(.catmullRom)
            }

            RuleMark(y: .value("Average", viewModel.averageYAxis))
                .lineStyle(StockChartStyle.averageLineStyle)
                .foregroundStyle(Color.theme.secondary)

            if let selectedModel = viewModel.selectedChartModel {
                PointMark(
                    x: .value("Date", selectedModel.xAxis),
                    y: .value("Gain Rate", selectedModel.yAxis)
                )
                .foregroundStyle(Color.theme.secondary)
                .symbolSize(70)

                RuleMark(x: .value("Date", selectedModel.xAxis))
                    .lineStyle(StockChartStyle.selectionLineStyle)
            }
        }
        .frame(height: UIScreen.screenHeight * 0.2)
        .chartXAxis(.hidden)
        .chartYAxis(.hidden)
        .chartOverlay { proxy in
            StockChartOverlayView(viewModel: viewModel, proxy: proxy)
        }
    }
}
