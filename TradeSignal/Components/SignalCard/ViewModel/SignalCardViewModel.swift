//
//  SignalCardViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 9.07.2024.
//

import SwiftUI

// MARK: - SignalCardViewModeling

protocol SignalCardViewModeling {
    var price: String { get }
    var traderName: String { get }
    var signalName: String { get }
    var gainRate: String { get }
    var subscriberCount: String { get }
    var marketType: String { get }
    var termType: String { get }
    var gainRateIconName: String { get }
    var subscriberCountIconName: String { get }
    var marketTypeIconName: String { get }
    var termIconName: String { get }
    var propertyNameColor: Color { get }
    var messageCount: String { get }
    var cardType: SignalCardType { get set }
    func didTapAddButton()
}

// MARK: - SignalCardViewModel

final class SignalCardViewModel: SignalCardViewModeling {
    private let model: SignalCardModel
    private let propertyIconsModel: SignalCardPropertyIconsModel?
    private let cartDataService: CartDataServicing
    private let toolbarViewModel: MarketplaceToolBarViewModel?
    var cardType: SignalCardType

    init(
        model: SignalCardModel,
        propertyIconsModel: SignalCardPropertyIconsModel?,
        cardType: SignalCardType,
        cartDataService: CartDataServicing = CartDataService(),
        toolbarViewModel: MarketplaceToolBarViewModel? = nil
    ) {
        self.model = model
        self.propertyIconsModel = propertyIconsModel
        self.cardType = cardType
        self.cartDataService = cartDataService
        self.toolbarViewModel = toolbarViewModel
    }
    
    var price: String {
        "$\(model.price.description)"
    }
    
    var traderName: String {
        model.traderName
    }
    
    var signalName: String {
        model.signalName
    }
    
    var gainRate: String {
        "%" + model.signalProperties.gainRate.description
    }
    
    var subscriberCount: String {
        model.signalProperties.subscriberCount.kFormat
    }
    
    var marketType: String {
        model.signalProperties.marketType.rawValue
    }
    
    var termType: String {
        model.signalProperties.termType.rawValue
    }
    
    var gainRateIconName: String {
        propertyIconsModel?.gainRate ?? ""
    }
    
    var subscriberCountIconName: String {
        propertyIconsModel?.subscriberCount ?? ""
    }
    
    var marketTypeIconName: String {
        propertyIconsModel?.marketType ?? ""
    }
    
    var termIconName: String {
        propertyIconsModel?.term ?? ""
    }
    
    var propertyNameColor: Color {
        model.signalProperties.gainRate < .zero ? .red : .green
    }
    
    var messageCount: String {
        "23/156"
    }
    
    func didTapAddButton() {
        addToCart()
        toolbarViewModel?.configureCartIconVisibility()
    }
}

// MARK: - Cart Operations

extension SignalCardViewModel {
    private func addToCart() {
        cartDataService.addToCart(signalId: model.signalId)
    }
}
