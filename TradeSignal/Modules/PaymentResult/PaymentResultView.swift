//
//  PaymentResultView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 3.09.2024.
//

import SwiftUI

struct PaymentResultView<ViewModel: PaymentResultViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel
    @EnvironmentObject private var marketplaceToolBarViewModel: MarketplaceToolBarViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .padding(.horizontal)
            .background(Color.theme.primary)
            .navigationTitle("Payment Result")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true) 
            .loading($viewModel.isLoadingActive)
    }
    
    var content: some View {
        ZStack {
            Color.theme.primary
            VStack {
                Spacer()
                LottieView(
                    animationName: "lottie_fail_animation",
                    loopMode: .playOnce, 
                    animationSize: .init(
                        width: UIScreen.screenWidth * 0.4,
                        height: UIScreen.screenWidth * 0.4
                    )
                )
                homePageButton
                Spacer(minLength: UIScreen.screenHeight * 0.4)
            }
        }
    }
}

private extension PaymentResultView {
    var resultIcon: some View {
        Text(viewModel.resultMessage)
    }
    
    var resultMessage: some View {
        Text(viewModel.resultMessage)
            .font(.body)
            .foregroundStyle(Color.theme.secondary)
    }
    
    var homePageButton: some View {
        Button(
            action: {
                marketplaceToolBarViewModel.isCartViewActive = false
            },
            label: {
                Text("Homepage")
                    .frame(maxWidth: .infinity)
                    .padding(.large)
                    .background(Color.theme.primaryVariant)
                    .cornerRadius(.huge)
                    .foregroundColor(.theme.secondary)
            }
        )
    }
}
