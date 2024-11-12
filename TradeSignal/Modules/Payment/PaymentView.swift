//
//  PaymentView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 2.09.2024.
//

import SwiftUI

struct PaymentView<ViewModel: PaymentViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .padding(.horizontal)
            .background(Color.theme.primary)
            .navigationTitle("Payment")
            .navigationBarTitleDisplayMode(.inline)
            .loading($viewModel.isLoadingActive)
            .navigationDestination(isPresented: $viewModel.isPaymentResultViewActive) {
                if let paymentResultViewModel = viewModel.paymentResultViewModel {
                    PaymentResultView(viewModel: paymentResultViewModel)
                }
            }
    }
    
    var content: some View {
        ZStack {
            Color.theme.primary
            VStack {
                cardView
                Spacer()
            }
        }
    }
}

private extension PaymentView {
    var cardView: some View {
        VStack(spacing: .large) {
            Text("Credit Card Information")
                .font(.headline)
                .foregroundColor(Color.theme.secondary)
                .padding(.top, .large)
            Group {
                cardHolderNameField
                cardNumberField
                expirationDateField
                cvvField
            }
            .padding()
            .background(Color.theme.primaryVariant)
            .foregroundColor(Color.theme.secondary)
            .cornerRadius(.small)
            .overlay(
                RoundedRectangle(cornerRadius: .small)
                    .stroke(Color.theme.secondary, lineWidth: .xxSmall)
            )
            .padding(.horizontal)
            payButton
        }
        .padding()
        .padding(.bottom, .xxLarge)
        .background(Color.theme.primaryVariant)
        .cornerRadius(.medium)
        .padding(.top, .huge)
    }
    
    var cardHolderNameField: some View {
        TextField("", text: $viewModel.cardHolderName)
            .onChange(of: viewModel.cardHolderName) { newValue in
                viewModel.cardHolderName = newValue.filter { $0.isLetter || $0.isWhitespace }
            }
            .placeholder(when: viewModel.cardHolderName.isEmpty) {
                Text("Cardholder Name").foregroundColor(.theme.secondary.opacity(0.3))
            }
    }
    
    var cardNumberField: some View {
        TextField("", text: $viewModel.cardNumber)
            .keyboardType(.numberPad)
            .onChange(of: viewModel.cardNumber) { newValue in
                let filtered = newValue.filter { $0.isNumber }
                let trimmed = String(filtered.prefix(16))
                viewModel.cardNumber = formatCardNumber(trimmed)
            }
            .placeholder(when: viewModel.cardNumber.isEmpty) {
                Text("Card Number").foregroundColor(.theme.secondary.opacity(0.3))
            }
    }
    
    var expirationDateField: some View {
        TextField("", text: $viewModel.expirationDate)
            .keyboardType(.numberPad)
            .onChange(of: viewModel.expirationDate) { newValue in
                let filtered = newValue.filter { $0.isNumber }
                let trimmed = String(filtered.prefix(4))
                viewModel.expirationDate = formatExpirationDate(trimmed)
            }
            .placeholder(when: viewModel.expirationDate.isEmpty) {
                Text("Expiration Date (MM/YY)").foregroundColor(.theme.secondary.opacity(0.3))
            }
    }
    
    var cvvField: some View {
        TextField("", text: $viewModel.cvv)
            .keyboardType(.numberPad)
            .onChange(of: viewModel.cvv) { newValue in
                viewModel.cvv = String(newValue.filter { $0.isNumber }.prefix(3))
            }
            .placeholder(when: viewModel.cvv.isEmpty) {
                Text("CVV").foregroundColor(.theme.secondary.opacity(0.3))
            }
    }
    
    var payButton: some View {
        Button(action: viewModel.didTapPayButton) {
            Text(viewModel.buttonTitle)
                .padding(.small)
                .frame(maxWidth: .infinity)
                .background(Color.theme.secondary)
                .cornerRadius(.huge)
                .foregroundColor(.theme.primaryVariant)
        }
        .padding(.horizontal)
        .padding(.top, .large)
    }
}

// MARK: - Helper functions

private extension PaymentView {
    private func formatCardNumber(_ number: String) -> String {
        number.enumerated().map { index, char in
            index > 0 && index % 4 == 0 ? " \(char)" : String(char)
        }.joined()
    }
    
    private func formatExpirationDate(_ date: String) -> String {
        let numbers = date.filter { $0.isNumber }
        if numbers.count > 2 {
            let index = numbers.index(numbers.startIndex, offsetBy: 2)
            return numbers[..<index] + "/" + numbers[index...]
        }
        return numbers
    }
}
