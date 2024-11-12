//
//  ProfileViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 20.08.2024.
//

import Foundation
import Combine

// MARK: - ProfileViewModeling

protocol ProfileViewModeling: ObservableObject {
    var isLoadingActive: Bool { get set }
    var isSubscriptionsViewActive: Bool { get set }
    var isRiskSurveyViewActive: Bool { get set }
    var signalCardModelList: [SignalCardModel] { get }
    var signalPropertyIcons: SignalCardPropertyIconsModel? { get }
    var subscriptionsViewModel: SubscriptionsViewModel? { get }
    var riskSurveyViewModel: RiskSurveyViewModel? { get }
    var error: Error? { get }
    func didTapSubscriptions()
    func didTapRiskSurvey()
}

// MARK: - ProfileViewModel

final class ProfileViewModel: ProfileViewModeling {
    @Published var isLoadingActive = false
    @Published var isSubscriptionsViewActive = false
    @Published var isRiskSurveyViewActive = false
    @Published var subscriptionsViewModel: SubscriptionsViewModel?
    @Published var riskSurveyViewModel: RiskSurveyViewModel?
    @Published private(set) var signalCardModelList: [SignalCardModel] = []
    @Published private(set) var signalPropertyIcons: SignalCardPropertyIconsModel?
    @Published private(set) var error: Error?
        
    private let userDataService: UserDataService
    private var allSignalCardModelList: [SignalCardModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(userDataService: UserDataService = .init()) {
        self.userDataService = userDataService
        setupBindings()
        fetchMarketplaceData()
    }
    
    private func fetchMarketplaceData() {
        isLoadingActive = true
        let req = UserRequestModel(parameters: .init(userId: 333))
        userDataService.fetchData(with: req)
    }
    
    private func updateWithResponse(_ response: UserResponseModel) {
        error = nil
    }
}

// MARK: - ProfileViewModeling Implementation

extension ProfileViewModel {
    func didTapSubscriptions() {
        subscriptionsViewModel = SubscriptionsViewModel()
        isSubscriptionsViewActive = true
    }
    
    func didTapRiskSurvey() {
        riskSurveyViewModel = RiskSurveyViewModel()
        isRiskSurveyViewActive = true
    }
}

// MARK: - Bindings

extension ProfileViewModel {
    
    private func setupBindings() {
        bindProfileData()
    }
    
    private func bindProfileData() {
        userDataService.responsePublisher
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    guard let self else { return }
                    self.isLoadingActive = false
                    if case .failure(let error) = completion {
                        self.error = error
                    }
                },
                receiveValue: { [weak self] response in
                    guard let self else { return }
                    updateWithResponse(response)
                }
            )
            .store(in: &cancellables)
    }
}
