//
//  StockChartStyle.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 27.08.2024.
//

import SwiftUI

// MARK: - StockChartStyle

enum StockChartStyle {
    static let areaGradient = LinearGradient(
        gradient: Gradient(colors: [
            .theme.primary,
            .theme.primary,
            .theme.primary.opacity(0.5),
            .theme.primary.opacity(0),
        ]),
        startPoint: .top,
        endPoint: .bottom
    )

    static let averageLineStyle = StrokeStyle(lineWidth: 1, dash: [3, 3])
    static let selectionLineStyle = StrokeStyle(lineWidth: 1, miterLimit: 8, dash: [2], dashPhase: 5)
}
