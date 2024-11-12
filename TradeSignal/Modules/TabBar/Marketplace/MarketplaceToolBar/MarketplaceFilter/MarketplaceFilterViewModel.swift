//
//  MarketplaceFilterViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.07.2024.
//

import SwiftUI

// MARK: - MarketplaceFilterViewModeling

protocol MarketplaceFilterViewModeling: ObservableObject {
    var tags: [String] { get }
    var selectedSortOption: MarketplaceSortOption { get set }
    func isTagSelected(_ tag: String) -> Bool
    func toggleTag(_ tag: String)
    func reset()
}

// MARK: - MarketplaceFilterViewModel

final class MarketplaceFilterViewModel: MarketplaceFilterViewModeling {
    @Published var tags: [String] = []
    @Published var selectedSortOption: MarketplaceSortOption = .highestPrice
    @Published var selectedTags: Set<String> = []
        
    func isTagSelected(_ tag: String) -> Bool {
        selectedTags.contains(tag)
    }
    
    func toggleTag(_ tag: String) {
        if selectedTags.contains(tag) {
            selectedTags.remove(tag)
        } else {
            selectedTags.insert(tag)
        }
    }
    
    func reset() {
        selectedTags.removeAll()
        selectedSortOption = .highestPerformance
    }
}
