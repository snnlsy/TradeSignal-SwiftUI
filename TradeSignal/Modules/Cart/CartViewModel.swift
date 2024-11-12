//
//  CartViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 1.09.2024.
//

import Foundation
import Combine

// MARK: - CartViewModeling

protocol CartViewModeling: ObservableObject {
    var isLoadingActive: Bool { get set }
    var isPaymentViewActive: Bool { get set }
    var signalCardModelList: [SignalCardModel] { get }
    var totalPrice: String { get }
    var error: Error? { get }
    var shouldDismiss: Bool { get }
    var paymentViewModel: PaymentViewModel? { get }
    func didTapPriceButton()
    func didTapXIcon(signalCardModel: SignalCardModel)
}

// MARK: - CartViewModel

final class CartViewModel: CartViewModeling {
    @Published private(set) var signalCardModelList: [SignalCardModel] = []
    @Published var isLoadingActive = false
    @Published var isPaymentViewActive = false
    @Published var totalPrice: String = ""
    @Published private(set) var error: Error?
    @Published var paymentViewModel: PaymentViewModel?
    @Published var shouldDismiss = false
    
    private let cartDataService: CartDataServicing
    private let marketplaceDataService: MarketplaceDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(
        cartDataService: CartDataServicing = CartDataService(),
        marketplaceDataService: MarketplaceDataService = .init()
    ) {
        self.cartDataService = cartDataService
        self.marketplaceDataService = marketplaceDataService
        setupBindings()
        fetchCartItems()
    }
}

// MARK: - CartViewModeling Implementation

extension CartViewModel {
    func didTapXIcon(signalCardModel: SignalCardModel) {
        removeFromCart(signalId: signalCardModel.signalId)
        isLoadingActive = false
    }
    
    func didTapPriceButton() {
        paymentViewModel = PaymentViewModel(model: .init(totalPrice: calculatedTotalPrice))
        isPaymentViewActive = true
    }
}

// MARK: - Data Operations

private extension CartViewModel {
    func fetchMarketplaceData(signalIdList: [String]) {
        Task { @MainActor in
            switch await marketplaceDataService.fetchData(with: .init()) {
            case .success(let response):
                updateCartItemList(of: response.signalCardList)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func calculateTotalPrice() {
        if calculatedTotalPrice.isZero {
            shouldDismiss = true
            return
        }
        totalPrice = String(format: "%.1f", calculatedTotalPrice)
    }
    
    var calculatedTotalPrice: Double {
        signalCardModelList.reduce(0) { $0 + $1.price }
    }
}

// MARK: - Cart Operations

private extension CartViewModel {
    func addToCart(signalId: String) {
        cartDataService.addToCart(signalId: signalId)
    }
    
    func removeFromCart(signalId: String) {
        cartDataService.removeFromCart(signalId: signalId)
        signalCardModelList.removeAll { $0.signalId == signalId }
        calculateTotalPrice()
    }
    
    func clearCart() {
        cartDataService.clearCart()
    }
    
    func fetchCartItems() {
        cartDataService.fetchCartItems()
    }
    
    func updateCartItemList(of list: [SignalCardModel]) {
        signalCardModelList = list
        calculateTotalPrice()
    }
}

// MARK: - Bindings

private extension CartViewModel {
    func setupBindings() {
        bindCartData()
    }
    
    func bindCartData() {
        cartDataService.cartItemsPublisher
            .sink { [weak self] items in
                guard let self = self else { return }
                fetchMarketplaceData(signalIdList: items)
            }
            .store(in: &cancellables)
    }
}
