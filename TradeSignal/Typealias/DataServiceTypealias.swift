//
//  DataService.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

typealias MarketplaceDataService = AsyncDataService<MarketplaceRequestModel, MarketplaceResponseModel>
typealias SignalsDataService = DataService<SignalsRequestModel, SignalsResponseModel>
typealias UserDataService = DataService<UserRequestModel, UserResponseModel>
typealias SignalDetailDataService = DataService<SignalDetailRequestModel, SignalDetailResponseModel>
typealias SignalNotificationsDataService = DataService<SignalNotificationsRequestModel, SignalNotificationsResponseModel>
typealias SendSignalDataService = DataService<SendSignalRequestModel, SendSignalResponseModel>
typealias SubscriptionsDataService = DataService<SubscriptionsRequestModel, SubscriptionsResponseModel>
typealias CancelSubscriptionDataService = DataService<CancelSubscriptionRequestModel, CancelSubscriptionResponseModel>
typealias RiskSurveyDataService = DataService<RiskSurveyRequestModel, RiskSurveyResponseModel>
typealias SendRiskSurveyDataService = DataService<SendRiskSurveyRequestModel, SendRiskSurveyResponseModel>
