//
//  UserRequestModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.08.2024.
//

// MARK: - UserRequestModel

struct UserRequestModel: BasePostRequest {
    var path: String = "/signals"
    var parameters: Encodable?

    init(parameters: UserRequestParameters) {
        self.parameters = parameters
    }
}

// MARK: - UserRequestParameters

struct UserRequestParameters: Encodable {
    let userId: Int
}

