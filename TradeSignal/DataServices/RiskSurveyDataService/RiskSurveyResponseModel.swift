//
//  RiskSurveyResponseModel.swift
//  TradeSignal
//
//  Created by SUlusoy on 5.09.2024.
//

// MARK: - RiskSurveyResponseModel

struct RiskSurveyResponseModel: Codable, Hashable {
    let questionList: [RiskSurveyModel]
}
