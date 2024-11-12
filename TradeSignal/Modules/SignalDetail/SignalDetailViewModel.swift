//
//  SignalDetailViewModel.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.08.2024.
//

import Foundation
import Combine

// MARK: - SignalsViewViewModeling

protocol SignalDetailViewModeling: ObservableObject {
    var chartViewModel: StockChartViewModel { get }
    var infoListModel: [SignalDetailInfoListModel] { get }
    var isLoadingActive: Bool { get set }
    var startDate: Date { get set }
    var endDate: Date { get set }
    var showStartCalendar: Bool { get set }
    var showEndCalendar: Bool { get set }
    var selectedChartModel: StockChartModel? { get set }
    var segments: StockChartViewModel.TimeRange { get set }
    var isStarred: Bool { get set }
    var starImageName: String { get }
    var error: Error? { get }
    func fetchSignalDetailData()
}

// MARK: - MarketplaceViewModel

final class SignalDetailViewModel: SignalDetailViewModeling {
    @Published private(set) var chartViewModel: StockChartViewModel
    @Published private(set) var infoListModel: [SignalDetailInfoListModel] = []
    @Published var isLoadingActive = true
    @Published var startDate = Date()
    @Published var endDate = Date()
    @Published var showStartCalendar = false
    @Published var showEndCalendar = false
    @Published var selectedChartModel: StockChartModel?
    @Published var segments: StockChartViewModel.TimeRange = .sevenDays
    @Published var isStarred = false
    @Published private(set) var error: Error?
        
    private let signalDetailDataService: SignalDetailDataService
    private var cancellables = Set<AnyCancellable>()
    
    init(
        model: SignalDetailModel,
        signalDetailDataService: SignalDetailDataService = .init(),
        chartViewModel: StockChartViewModel = StockChartViewModel()
    ) {
        self.signalDetailDataService = signalDetailDataService
        self.chartViewModel = chartViewModel
        setupBindings()
        fetchSignalDetailData()
    }
    
    func fetchSignalDetailData() {
        isLoadingActive = true
        let req = SignalDetailRequestModel(parameters: .init(signalId: 333))
        signalDetailDataService.fetchData(with: req)
    }
    
    private func updateWithResponse(_ response: SignalsResponseModel) {
        error = nil
    }
}

// MARK: - Bindings

extension SignalDetailViewModel {
    
    private func setupBindings() {
        bindSignalsData()
    }
    
    private func bindSignalsData() {
        signalDetailDataService.responsePublisher
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
                    chartViewModel.updateData(stockChartModelList: response.chart)
                    chartViewModel.animateChart()
                    infoListModel = response.info
                }
            )
            .store(in: &cancellables)
    }
}

// MARK: - SignalDetailViewModeling Implementation

extension SignalDetailViewModel {
    var starImageName: String {
        isStarred ? "star.fill" : "star"
    }
}
