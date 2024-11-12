//
//  MarketplaceView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 24.05.2024.
//

import SwiftUI

// MARK: - MarketplaceView

struct MarketplaceView<ViewModel: MarketplaceViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            content
                .padding([.horizontal, .top])
                .background(Color.theme.primary)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar { toolbarContent }
                .loading($viewModel.isLoadingActive)
                .navigationDestination(isPresented: $viewModel.isDetailViewActive) {
                    if let signalDetailViewModel = viewModel.signalDetailViewModel {
                        SignalDetailView(viewModel: signalDetailViewModel)
                    }
                }
        }
    }
}

// MARK: - Content Views

private extension MarketplaceView {
    var content: some View {
        ScrollView {
            signalCardList
        }
    }
    
    var signalCardList: some View {
        LazyVStack(spacing: .small) {
            ForEach(viewModel.signalCardModelList, id: \.self) { signalCardModel in
                let signalCardViewModel = SignalCardViewModel(
                    model: signalCardModel,
                    propertyIconsModel: viewModel.signalPropertyIcons,
                    cardType: .marketplace,
                    toolbarViewModel: viewModel.toolBarViewModel
                )
                SignalCardView(viewModel: signalCardViewModel)
                    .onTapGesture {
                        viewModel.didTapSignalCard(for: signalCardModel)
                    }
            }
        }
    }
}

// MARK: - Toolbar Content

private extension MarketplaceView {
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .principal) {
            MarketplaceToolBarView(viewModel: viewModel.toolBarViewModel)
        }
    }
}

// MARK: - Preview

#Preview {
    MarketplaceView(
        viewModel: MarketplaceViewModel()
    )
}
