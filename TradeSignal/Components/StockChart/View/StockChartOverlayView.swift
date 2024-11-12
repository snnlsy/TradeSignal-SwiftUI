//
//  StockChartOverlayView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 27.08.2024.
//

import SwiftUI
import Charts

// MARK: - StockChartOverlayView

struct StockChartOverlayView: View {
    @ObservedObject var viewModel: StockChartViewModel
    let proxy: ChartProxy

    var body: some View {
        GeometryReader { geometry in
            Rectangle()
                .fill(.clear)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            updateSelectedValue(value: value, proxy: proxy, geometry: geometry)
                        }
                        .onEnded { _ in
                            viewModel.selectedChartModel = nil
                        }
                )
        }
    }

    private func updateSelectedValue(
        value: DragGesture.Value,
        proxy: ChartProxy,
        geometry: GeometryProxy
    ) {
        let plotFrame = proxy.plotAreaFrame
        let currentX = value.location.x - geometry[plotFrame].origin.x
        guard currentX >= 0, currentX <= proxy.plotAreaSize.width else { return }

        let nearestValue = viewModel.chartModelList.min { model1, model2 in
            let distance1 = abs((proxy.position(forX: model1.xAxis) ?? 0) - currentX)
            let distance2 = abs((proxy.position(forX: model2.xAxis) ?? 0) - currentX)
            return distance1 < distance2
        }

        viewModel.selectedChartModel = nearestValue
    }
}
