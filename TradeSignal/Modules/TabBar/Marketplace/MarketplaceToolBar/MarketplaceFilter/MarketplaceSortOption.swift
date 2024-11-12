//
//  MarketplaceSortOption.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.07.2024.
//

// MARK: - MarketplaceSortOption

enum MarketplaceSortOption: String, CaseIterable {
    case highestPerformance = "Highest Performance"
    case lowestPerformance = "Lowest Performance"
    case highestMember = "Highest Member"
    case lowestMember = "Lowest Member"
    case highestPrice = "Highest Price"
    case lowestPrice = "Lowest Price"
    
    static var defaulValue: MarketplaceSortOption {
        .highestPerformance
    }
}
