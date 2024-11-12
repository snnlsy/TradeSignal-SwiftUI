//
//  PaymentResultViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 3.09.2024.
//

import Foundation
import Combine

// MARK: - PaymentResultViewModeling

protocol PaymentResultViewModeling: ObservableObject {
    var isLoadingActive: Bool { get set }
    var isPaymentResultViewActive: Bool { get set }
    var resultMessage: String { get }
    var error: Error? { get }
    var shouldDismiss: Bool { get }
}

// MARK: - PaymentResultViewModel

final class PaymentResultViewModel: PaymentResultViewModeling {
    @Published private(set) var signalCardModelList: [SignalCardModel] = []
    @Published var isLoadingActive = false
    @Published var isPaymentResultViewActive = false
    @Published private(set) var error: Error?
    @Published var shouldDismiss = false

    private let model: PaymentResultModel
    private var cancellables = Set<AnyCancellable>()
    
    init(model: PaymentResultModel) {
        self.model = model
        setupBindings()
    }
}

// MARK: - PaymentViewModeling Implementation

extension PaymentResultViewModel {
    var resultMessage: String {
        model.resultMessage
    }
}

// MARK: - Bindings

private extension PaymentResultViewModel {
    func setupBindings() {
        bindPaymentResultData()
    }
    
    func bindPaymentResultData() {

    }
}
