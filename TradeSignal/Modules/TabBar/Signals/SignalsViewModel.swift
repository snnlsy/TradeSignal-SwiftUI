//
//  SignalsViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 20.08.2024.
//

import Foundation
import Combine

// MARK: - SignalsViewViewModeling

protocol SignalsViewModeling: ObservableObject {
    var isLoadingActive: Bool { get set }
    var isSignalNotificationsViewActive: Bool { get set }
    var signalCardModelList: [SignalCardModel] { get }
    var signalPropertyIcons: SignalCardPropertyIconsModel? { get }
    var signalNotificationsViewModel: SignalNotificationsViewModel? { get }
    var error: Error? { get }
    func didTapSignal()
}

// MARK: - SignalsViewModel

final class SignalsViewModel: SignalsViewModeling {
    @Published var isLoadingActive = false
    @Published var isSignalNotificationsViewActive = false
    @Published private(set) var signalCardModelList: [SignalCardModel] = []
    @Published private(set) var signalPropertyIcons: SignalCardPropertyIconsModel?
    @Published private(set) var signalNotificationsViewModel: SignalNotificationsViewModel?
    @Published private(set) var error: Error?
        
    private let signalsDataService: SignalsDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(signalsDataService: SignalsDataService = .init()) {
        self.signalsDataService = signalsDataService
        setupBindings()
        fetchMarketplaceData()
    }
    
    private func fetchMarketplaceData() {
        isLoadingActive = true
        let req = SignalsRequestModel(parameters: .init(userId: 4499))
        signalsDataService.fetchData(with: req)
    }
    
    private func updateWithResponse(_ response: SignalsResponseModel) {
        signalCardModelList = response.signalCardList
        signalPropertyIcons = response.signalPropertyIcons
        error = nil
    }
}

// MARK: - Bindings

extension SignalsViewModel {
    
    private func setupBindings() {
        bindSignalsData()
    }
    
    private func bindSignalsData() {
        signalsDataService.responsePublisher
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

// MARK: - SignalsViewViewModeling Implementation

extension SignalsViewModel {
    func didTapSignal() {
        signalNotificationsViewModel = SignalNotificationsViewModel(signalId: "")
        isSignalNotificationsViewActive = true
    }
}
