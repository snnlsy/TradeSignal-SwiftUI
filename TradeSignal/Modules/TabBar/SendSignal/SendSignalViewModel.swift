//
//  SendSignalViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

import Foundation
import Combine

// MARK: - SendSignalViewModeling

protocol SendSignalViewModeling: ObservableObject {
    var isLoadingActive: Bool { get set }
    var error: Error? { get }
    var signalList: [SignalEntity] { get }
    var selectedSignal: SignalEntity { get set }
    var stopLoss: String { get set }
    var selectedTradeType: TradeType { get set }
    func didTapSend()
}

// MARK: - SendSignalViewModel

final class SendSignalViewModel: SendSignalViewModeling {
    @Published var selectedSignal: SignalEntity
    @Published var selectedTradeType: TradeType = .buy
    @Published var isLoadingActive = false
    @Published var stopLoss: String = ""
    @Published private(set) var error: Error?
    var signalList: [SignalEntity]
    
    private let sendSignalDataService: SendSignalDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(
        signalList: [SignalEntity],
        sendSignalDataService: SendSignalDataService = .init()
    ) {
        self.sendSignalDataService = sendSignalDataService
        self.signalList = signalList
        selectedSignal = signalList.first!
        setupBindings()
    }
    
    private func postSendSignalData() {
        isLoadingActive = true
        let req = SendSignalRequestModel(parameters: .init(signalId: selectedSignal.signalId, stopLoss: 223.4, tradeType: .buy))
        sendSignalDataService.fetchData(with: req)
    }
    
    private func updateWithResponse(_ response: SignalsResponseModel) {
        error = nil
    }
}

// MARK: - Bindings

extension SendSignalViewModel {
    
    private func setupBindings() {
        bindSignalsData()
    }
    
    private func bindSignalsData() {
        sendSignalDataService.responsePublisher
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
                }
            )
            .store(in: &cancellables)
    }
}

// MARK: - SendSignalViewModeling Implementation

extension SendSignalViewModel {
    func didTapSend() {
        postSendSignalData()
    }
}
