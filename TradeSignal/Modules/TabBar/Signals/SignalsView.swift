//
//  SignalsView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 24.05.2024.
//

import SwiftUI

// MARK: - SignalsView

struct SignalsView<ViewModel: SignalsViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            content
                .padding(.horizontal)
                .background(Color.theme.primary)
                .navigationTitle("Signals")
                .navigationBarTitleDisplayMode(.inline)
                .loading($viewModel.isLoadingActive)
                .navigationDestination(isPresented: $viewModel.isSignalNotificationsViewActive) {
                    if let vm = viewModel.signalNotificationsViewModel {
                        SignalNotificationsView(viewModel: vm)
                    }
                }
        }
    }
}


// MARK: - Content Views

private extension SignalsView {
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
                    cardType: .signals
                )
                SignalCardView(viewModel: signalCardViewModel)
                .onTapGesture {
                        viewModel.didTapSignal()
                }
            }
        }
    }
}

#Preview {
    SignalsView(
        viewModel: SignalsViewModel()
    )
}
