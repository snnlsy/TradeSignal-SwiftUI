//
//  MarketplaceViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 26.05.2024.
//

import Foundation
import Combine

// MARK: - MarketplaceViewModeling

protocol MarketplaceViewModeling: ObservableObject {
    var searchText: String { get }
    var isSearchActive: Bool { get }
    var isLoadingActive: Bool { get set }
    var isDetailViewActive: Bool { get set }
    var signalCardModelList: [SignalCardModel] { get }
    var signalPropertyIcons: SignalCardPropertyIconsModel? { get }
    var toolBarViewModel: MarketplaceToolBarViewModel { get }
    var signalDetailViewModel: SignalDetailViewModel? { get }
    var error: Error? { get }
    func didTapSignalCard(for signal: SignalCardModel)
}

// MARK: - MarketplaceViewModel

final class MarketplaceViewModel: MarketplaceViewModeling {
    @Published var searchText = ""
    @Published var isSearchActive = false
    @Published var isLoadingActive = true
    @Published var isDetailViewActive = false
    @Published var signalDetailViewModel: SignalDetailViewModel?
    @Published private(set) var signalCardModelList: [SignalCardModel] = []
    @Published private(set) var signalPropertyIcons: SignalCardPropertyIconsModel?
    @Published private(set) var error: Error?
    
    let toolBarViewModel: MarketplaceToolBarViewModel
    
    private let marketplaceDataService: MarketplaceDataService
    private var allSignalCardModelList: [SignalCardModel] = []
    private var cancellables = Set<AnyCancellable>()
    
    init(
        marketplaceDataService: MarketplaceDataService = .init(),
        toolBarViewModel: MarketplaceToolBarViewModel = MarketplaceToolBarViewModel()
    ) {
        self.marketplaceDataService = marketplaceDataService
        self.toolBarViewModel = toolBarViewModel
        setupBindings()
        fetchMarketplaceData()
    }
}

// MARK: - Data Fetching Operations

private extension MarketplaceViewModel {
    
    func fetchMarketplaceData() {
        isLoadingActive = true
        Task {
            switch await marketplaceDataService.fetchData(with: .init()) {
            case .success(let response):
                await MainActor.run {
                    updateWithResponse(response)
                    toolBarViewModel.filterViewModel.selectedSortOption = MarketplaceSortOption.defaulValue
                    isLoadingActive = false
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateWithResponse(_ response: MarketplaceResponseModel) {
        allSignalCardModelList = response.signalCardList
        signalPropertyIcons = response.signalPropertyIcons
        toolBarViewModel.filterViewModel.tags = response.filterOptions
        filterSignalCardModelList()
        error = nil
    }
}

// MARK: - Bindings

private extension MarketplaceViewModel {
    
    func setupBindings() {
        bindSearchText()
        bindMarketplaceDataByFilter()
        bindMarketplaceDataBySort()
    }

    func bindSearchText() {
        toolBarViewModel.$searchText
            .assign(to: &$searchText)
        
        $searchText
            .debounce(for: .milliseconds(200), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.filterSignalCardModelList()
            }
            .store(in: &cancellables)
    }
    
    func bindMarketplaceDataBySort() {
        toolBarViewModel.filterViewModel.$selectedSortOption
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyFiltersAndSorting()
            }
            .store(in: &cancellables)
    }

    func bindMarketplaceDataByFilter() {
        toolBarViewModel.filterViewModel.$selectedTags
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.applyFiltersAndSorting()
            }
            .store(in: &cancellables)
    }
}

// MARK: - Button Actions

extension MarketplaceViewModel {
    
    func didTapSignalCard(for signal: SignalCardModel) {
        signalDetailViewModel = SignalDetailViewModel(model: .init(id: signal.signalId))
        isDetailViewActive = true
    }
}

// MARK: - Data Operation Helpers

private extension MarketplaceViewModel {
    
    func filterSignalCardModelList() {
        if searchText.isEmpty {
            signalCardModelList = allSignalCardModelList
        } else {
            signalCardModelList = allSignalCardModelList.filter { signal in
                signal.signalName.lowercased().contains(searchText.lowercased()) ||
                signal.traderName.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    func applyFiltersAndSorting() {
        var filteredList = allSignalCardModelList
        
        if !toolBarViewModel.filterViewModel.selectedTags.isEmpty {
            filteredList = filteredList.filter { signal in
                let containsAllTags = toolBarViewModel.filterViewModel.selectedTags.allSatisfy { tag in
                    if tag.lowercased() == "positive performance" {
                        return signal.signalProperties.gainRate >= .zero
                    } else if tag.lowercased() == "negative performance" {
                        return signal.signalProperties.gainRate < .zero
                    } else {
                        return signal.signalName.lowercased().contains(tag.lowercased()) ||
                               signal.traderName.lowercased().contains(tag.lowercased()) ||
                               signal.signalProperties.marketType.rawValue.lowercased().contains(tag.lowercased()) ||
                               signal.signalProperties.termType.rawValue.lowercased().contains(tag.lowercased())
                    }
                }
                return containsAllTags
            }
        }
        
        signalCardModelList = switch toolBarViewModel.filterViewModel.selectedSortOption {
        case .lowestPerformance:
            filteredList.sorted { $0.signalProperties.gainRate < $1.signalProperties.gainRate }
        case .highestPerformance:
            filteredList.sorted { $0.signalProperties.gainRate > $1.signalProperties.gainRate }
        case .lowestMember:
            filteredList.sorted { $0.signalProperties.subscriberCount < $1.signalProperties.subscriberCount }
        case .highestMember:
            filteredList.sorted { $0.signalProperties.subscriberCount > $1.signalProperties.subscriberCount }
        case .lowestPrice:
            filteredList.sorted { $0.price < $1.price }
        case .highestPrice:
            filteredList.sorted { $0.price > $1.price }
        }
    }
}
