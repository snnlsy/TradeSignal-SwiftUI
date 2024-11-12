//
//  SignalNotificationsViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 3.09.2024.
//

import Foundation
import Combine

protocol SignalNotificationsViewModeling: ObservableObject {
    var notificationModelList: [SignalNotificationsModel] { get }
    var isLoadingActive: Bool { get set }
    var error: Error? { get }
    func fetchSignalNotificationsData()
}

final class SignalNotificationsViewModel: SignalNotificationsViewModeling {
    @Published private(set) var notificationModelList: [SignalNotificationsModel] = []
    @Published var isLoadingActive = true
    @Published var isStarred = false
    @Published private(set) var error: Error?
        
    private let signalNotificationsDataService: SignalNotificationsDataService
    private var cancellables = Set<AnyCancellable>()
    private let signalId: String

    init(
        signalId: String,
        signalNotificationsDataService: SignalNotificationsDataService = .init()
    ) {
        self.signalId = signalId
        self.signalNotificationsDataService = signalNotificationsDataService
        setupBindings()
        fetchSignalNotificationsData()
    }
    
    func fetchSignalNotificationsData() {
        isLoadingActive = true
        let request = SignalNotificationsRequestModel(parameters: .init(signalId: "4499"))
        signalNotificationsDataService.fetchData(with: request)
    }
}

// MARK: - Bindings

extension SignalNotificationsViewModel {
    
    private func setupBindings() {
        bindSignalNotificationsData()
    }
    
    private func bindSignalNotificationsData() {
        signalNotificationsDataService.responsePublisher
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
                    notificationModelList = response.signalNotificationsList
                }
            )
            .store(in: &cancellables)
    }
}
