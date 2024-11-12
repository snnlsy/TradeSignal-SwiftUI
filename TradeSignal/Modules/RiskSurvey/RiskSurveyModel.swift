//
//  RiskSurveyModel.swift
//  TradeSignal
//
//  Created by SUlusoy on 5.09.2024.
//

import Foundation

struct RiskSurveyModel: Codable, Hashable {
    let number: Int
    let question: String
    let answers: [String]
}
