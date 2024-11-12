//
//  SubscriptionsViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

import Foundation
import Combine

// MARK: - SubscriptionsViewModeling

protocol SubscriptionsViewModeling: ObservableObject {
    var subscriptionStatusType: SubscriptionsSegments { get set }
    var selectedSubscriptionsList: [SubscriptionsModel] { get }
    var isLoadingActive: Bool { get set }
    var error: Error? { get }
    func didPickerChangeValue()
    func didTapCancelButton(model: SubscriptionsModel)
}

// MARK: - SubscriptionsViewModel

final class SubscriptionsViewModel: SubscriptionsViewModeling {
    private let subscriptionsDataService: SubscriptionsDataService
    private let cancelSubscriptionDataService: CancelSubscriptionDataService
    @Published var selectedSubscriptionsList: [SubscriptionsModel] = []
    @Published var subscriptionStatusType: SubscriptionsSegments = .active
    @Published var isLoadingActive = false
    @Published private(set) var error: Error?
    var subscriptionsList: [SubscriptionsModel] = []

    private var cancellables = Set<AnyCancellable>()
    
    init(
        subscriptionsDataService: SubscriptionsDataService = .init(),
        cancelSubscriptionDataService: CancelSubscriptionDataService = .init()
    ) {
        self.subscriptionsDataService = subscriptionsDataService
        self.cancelSubscriptionDataService = cancelSubscriptionDataService
        setupBindings()
        fetchSubscriptionsData()
    }
}

// MARK: - SubscriptionsViewModeling Implementation

extension SubscriptionsViewModel {
    func didPickerChangeValue() {
        filterSubscriptionsList()
    }
    
    func didTapCancelButton(model: SubscriptionsModel) {
        postCancelSubscriptionData(model: model)
    }
}

// MARK: - Data Operations

private extension SubscriptionsViewModel {
    func fetchSubscriptionsData() {
        isLoadingActive = true
        subscriptionsDataService.fetchData(with: .init())
    }
    
    func postCancelSubscriptionData(model: SubscriptionsModel) {
        isLoadingActive = true
        let req = CancelSubscriptionRequestModel(parameters: .init(signalId: model.signalId))
        cancelSubscriptionDataService.fetchData(with: req)
    }
    
    func handleSubscriptionsResponse(with response: [SubscriptionsModel]) {
        subscriptionsList = response
        filterSubscriptionsList()
    }
    
    func filterSubscriptionsList() {
        switch subscriptionStatusType {
        case .active:
            selectedSubscriptionsList = subscriptionsList.filter { $0.status == .active || $0.status == .pending }
        case .expired:
            selectedSubscriptionsList = subscriptionsList.filter { $0.status == .expired }
        }
    }
}

// MARK: - Bindings

private extension SubscriptionsViewModel {
    func setupBindings() {
        bindSubscriptionsData()
        bindCancelSubscriptionData()
    }
    
    func bindSubscriptionsData() {
        subscriptionsDataService.responsePublisher
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
                    handleSubscriptionsResponse(with: response.subscriptionList)
                }
            )
            .store(in: &cancellables)
    }
    
    func bindCancelSubscriptionData() {
        cancelSubscriptionDataService.responsePublisher
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
                    handleSubscriptionsResponse(with: response.subscriptionList)
                }
            )
            .store(in: &cancellables)
    }
}
