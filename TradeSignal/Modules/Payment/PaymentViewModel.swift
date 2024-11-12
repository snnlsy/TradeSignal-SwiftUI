//
//  PaymentViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 2.09.2024.
//

import Foundation
import Combine

// MARK: - PaymentViewModeling

protocol PaymentViewModeling: ObservableObject {
    var isLoadingActive: Bool { get set }
    var isPaymentResultViewActive: Bool { get set }
    var cardNumber: String { get set }
    var expirationDate: String { get set }
    var cvv: String { get set }
    var cardHolderName: String { get set }
    var buttonTitle: String { get set }
    var error: Error? { get }
    var shouldDismiss: Bool { get }
    var paymentResultViewModel: PaymentResultViewModel? { get }
    func didTapPayButton()
}

// MARK: - PaymentViewModel

final class PaymentViewModel: PaymentViewModeling {
    @Published private(set) var signalCardModelList: [SignalCardModel] = []
    @Published var isLoadingActive = false
    @Published var isPaymentResultViewActive = false
    @Published var totalPrice: String = ""
    @Published private(set) var error: Error?
    @Published var shouldDismiss = false
    @Published var cardNumber: String = ""
    @Published var expirationDate: String = ""
    @Published var cvv: String = ""
    @Published var cardHolderName: String = ""
    @Published var buttonTitle: String = ""
    @Published var paymentResultViewModel: PaymentResultViewModel?

    private let model: PaymentModel
    private var cancellables = Set<AnyCancellable>()
    
    init(model: PaymentModel) {
        self.model = model
        configureView()
        setupBindings()
    }
    
    private func configureView() {
        buttonTitle = String("Pay $") + String(format: "%.1f", model.totalPrice)
    }
}

// MARK: - PaymentViewModeling Implementation

extension PaymentViewModel {
    
    func didTapPayButton() {
        paymentResultViewModel = PaymentResultViewModel(model: .init(
            resultMessage: "Odeme Basarili",
            resultIconName: ""
        ))
        isPaymentResultViewActive = true
    }
}

// MARK: - Bindings

extension PaymentViewModel {
    private func setupBindings() {
        bindPaymentData()
    }
    
    private func bindPaymentData() {

    }
}
