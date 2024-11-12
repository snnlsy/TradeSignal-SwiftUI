//
//  SendSignalView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

import SwiftUI

// MARK: - SendSignalView

struct SendSignalView<ViewModel: SendSignalViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        configureAppearance()
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.theme.primary
                content
            }
            .padding(.horizontal)
            .background(Color.theme.primary)
            .navigationTitle("Send Signal")
            .navigationBarTitleDisplayMode(.inline)
            .loading($viewModel.isLoadingActive)
        }
    }
}


// MARK: - Content Views

private extension SendSignalView {
    var content: some View {
        VStack {
            VStack(spacing: .xLarge) {
                sendSignalView
                stopLossView
                tradeType
                sendButton
            }
            .frame(maxWidth: .infinity)
            .padding(.xxLarge)
            .background(Color.theme.primaryVariant)
            .cornerRadius(.medium)
            .padding(.top, UIScreen.screenHeight * 0.1)
            Spacer()
        }
    }
    
    var sendSignalView: some View {
        Picker("", selection: $viewModel.selectedSignal) {
            ForEach(viewModel.signalList, id: \.self) { signal in
                Text(signal.signalName)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.medium)
        .background(Color.theme.primary)
        .foregroundColor(.theme.secondary)
        .cornerRadius(.medium)
        .pickerStyle(.menu)

    }
    
    var stopLossView: some View {
        TextField("", text: $viewModel.stopLoss)
            .keyboardType(.numberPad)
            .placeholder(when: viewModel.stopLoss.isEmpty) {
                Text("Stop Loss").foregroundColor(.theme.secondary.opacity(0.3))
            }
            .padding()
            .background(Color.theme.primary)
            .foregroundColor(.theme.secondary)
            .cornerRadius(.medium)
    }
    
    var tradeType: some View {
        Picker("", selection: $viewModel.selectedTradeType) {
            ForEach(TradeType.allCases, id: \.self) { type in
                Text(type.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .frame(maxWidth: .infinity)
        .padding(.medium)
        .background(Color.theme.primary)
        .foregroundColor(.theme.secondary)
        .cornerRadius(.medium)
    }
    
    var sendButton: some View {
        Button(action: { viewModel.didTapSend() }) {
            Text("Send Signal")
                .frame(maxWidth: .infinity)
                .padding(.medium)
                .background(Color.theme.secondary)
                .foregroundColor(.theme.primary)
                .cornerRadius(.huge)
        }
    }
}

extension SendSignalView {
    func configureAppearance() {
        UISegmentedControl.appearance().backgroundColor = UIColor(.theme.primaryVariant)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.theme.primary)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.theme.secondary)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.theme.secondary)], for: .normal)
    }
}

#Preview {
    SendSignalView(
        viewModel: SendSignalViewModel(signalList: [.init(signalId: "TestsignalId", traderId: "TesttraderId", signalName: "TestsignalName", traderName: "TesttraderName")])
    )
}
