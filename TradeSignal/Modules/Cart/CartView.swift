//
//  CartView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 1.09.2024.
//

import SwiftUI

// MARK: - CartView

struct CartView<ViewModel: CartViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel
    @Environment(\.dismiss) private var dismiss

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            content
                .padding(.horizontal)
                .background(Color.theme.primary)
                .navigationTitle("Cart")
                .navigationBarItems(leading: closeButton)
                .navigationBarTitleDisplayMode(.inline)
                .loading($viewModel.isLoadingActive)
                .onChange(of: viewModel.shouldDismiss) { _ in
                    dismiss()
                }
                .navigationDestination(isPresented: $viewModel.isPaymentViewActive) {
                    if let paymentViewModel = viewModel.paymentViewModel {
                        PaymentView(viewModel: paymentViewModel)
                    }
                }
        }
    }
    
    var content: some View {
        VStack {
            signalList
            Spacer()
            priceContent
        }
    }
}

// MARK: - Navigation Bar Items

private extension CartView {
    var closeButton: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark")
                .foregroundColor(.theme.secondary)
        }
    }
}

// MARK: - Cart Item List

private extension CartView {
    var signalList: some View {
        List(viewModel.signalCardModelList, id: \.self) { signalCardModel in
            signalListItem(signalCardModel: signalCardModel)
                .listRowInsets(EdgeInsets())
                .padding(.vertical, .small)
                .background(Color.theme.primary)
        }
        .listStyle(PlainListStyle())
        .foregroundStyle(Color.theme.secondary)
    }
    
    func signalListItem(signalCardModel: SignalCardModel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(signalCardModel.traderName)
                    .bold()
                Text(signalCardModel.signalName)
            }
            .font(.caption)
            
            Spacer()
            
            Text(signalCardModel.price)
                .frame(width: .xHuge)
                .font(.footnote)
                .bold()
                .padding(.small)
                .background(Color.theme.primary)
                .cornerRadius(.small)
            
            Image(systemName: "x.square")
                .onTapGesture {
                    viewModel.didTapXIcon(signalCardModel: signalCardModel)
                }
        }
        .padding(.medium)
        .foregroundColor(.theme.secondary)
        .background(Color.theme.primaryVariant)
        .clipShape(RoundedRectangle(cornerRadius: .medium))
    }
}

// MARK: - Price Content

private extension CartView {
    var priceContent: some View {
        Button(
            action: {
                viewModel.didTapPriceButton()
            },
            label: {
                HStack {
                    Text("Make Payment")
                        .padding(.leading, .small)
                        .foregroundColor(.theme.primary)
                    Spacer()
                    Text("Total: $\(viewModel.totalPrice)")
                        .frame(width: UIScreen.screenWidth * 0.3)
                        .padding(.small)
                        .background(Color.theme.primaryVariant)
                        .cornerRadius(.huge)
                }
                .padding(.small)
                .frame(maxWidth: .infinity)
                .background(Color.theme.secondary)
                .cornerRadius(.huge)
                .foregroundColor(.theme.secondary)
            }
        )
    }
}
