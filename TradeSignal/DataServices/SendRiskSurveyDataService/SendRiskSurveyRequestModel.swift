//
//  SendRiskSurveyRequestModel.swift
//  TradeSignal
//
//  Created by SUlusoy on 5.09.2024.
//

// MARK: - SendRiskSurveyRequestModel

struct SendRiskSurveyRequestModel: BasePostRequest {
    var path: String = "/sendrisksurvey"
    var parameters: Encodable?

    init(parameters: SendRiskSurveyRequestParameters) {
        self.parameters = parameters
    }
}

// MARK: - SendRiskSurveyRequestParameters

struct SendRiskSurveyRequestParameters: Encodable {
    let answers: [Int: Int]
}
