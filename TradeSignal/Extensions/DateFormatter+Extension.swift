//
//  DateFormatter+Extension.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 27.08.2024.
//

import Foundation

extension DateFormatter {
    static let yyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()

    static let mediumDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }()
}
