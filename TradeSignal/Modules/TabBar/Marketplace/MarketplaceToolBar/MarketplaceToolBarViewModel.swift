//
//  MarketplaceToolBarViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 19.07.2024.
//

import Foundation

// MARK: - MarketplaceToolBarViewModeling

protocol MarketplaceToolBarViewModeling: ObservableObject {
    var searchText: String { get set }
    var isCartIconVisible: Bool { get }
    var isCartViewActive: Bool { get set }
    var isSearchActive: Bool { get }
    var isItemsActive: Bool { get }
    var isFilterSheetActive: Bool { get set }
    func activateSearch()
    func deactivateSearch()
    func didTapFilterIcon()
    func didTapCartIcon()
    func configureCartIconVisibility()
    func configureItemsVisibility()
    var filterViewModel: MarketplaceFilterViewModel { get }
    var cartViewModel: CartViewModel? { get }
}

// MARK: - MarketplaceToolBarViewModel

final class MarketplaceToolBarViewModel: MarketplaceToolBarViewModeling {
    @Published var searchText: String = ""
    @Published var isCartIconVisible: Bool = false
    @Published var isCartViewActive: Bool = false
    @Published var isSearchActive: Bool = false
    @Published var isFilterSheetActive: Bool = false
    @Published var cartViewModel: CartViewModel?
    @Published var isItemsActive: Bool = false

    private let cartDataService: CartDataServicing
    let filterViewModel: MarketplaceFilterViewModel

    init(
        filterViewModel: MarketplaceFilterViewModel = MarketplaceFilterViewModel(),
        cartDataService: CartDataServicing = CartDataService()
    ) {
        self.filterViewModel = filterViewModel
        self.cartDataService = cartDataService
    }
    
    func activateSearch() {
        isSearchActive = true
    }
    
    func deactivateSearch() {
        isSearchActive = false
        searchText = ""
    }
    
    func didTapFilterIcon() {
        isFilterSheetActive = true
    }
    
    func didTapCartIcon() {
        cartViewModel = CartViewModel()
        isCartViewActive = true
    }
    
    func configureCartIconVisibility() {
        isCartIconVisible = cartDataService.itemCount != 0
    }
    
    func configureItemsVisibility() {
        isItemsActive = true
    }
}
