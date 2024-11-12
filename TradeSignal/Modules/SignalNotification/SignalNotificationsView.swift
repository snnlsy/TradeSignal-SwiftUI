//
//  SignalNotificationsView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 3.09.2024.
//

import SwiftUI

// MARK: - SignalNotificationsView

struct SignalNotificationsView<ViewModel: SignalNotificationsViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        content
            .padding(.horizontal)
            .background(Color.theme.primary)
            .navigationTitle("Signals")
            .loading($viewModel.isLoadingActive)
    }
    
    var content: some View {
        ScrollView {
            notificationList
        }
    }
}

// MARK: - Notification List

private extension SignalNotificationsView {
    var notificationList: some View {
        LazyVStack(spacing: .medium) {
            ForEach(viewModel.notificationModelList, id: \.self) { notificationModel in
                noticationView(model: notificationModel)
            }
        }
    }
    
    func noticationView(model: SignalNotificationsModel) -> some View {
        VStack() {
            HStack {
                Text("Date:")
                    .bold()
                Text(model.date)
                Spacer()
            }
            HStack {
                Text("Instrument:")
                    .bold()
                Text(model.instruments)
                Spacer()
            }
            HStack {
                Text("Stop Loss:")
                    .bold()
                Text(model.stopLoss)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.theme.primaryVariant)
        .foregroundColor(.theme.secondary)
        .font(.callout)
        .cornerRadius(.medium)
    }
}

// MARK: - Preview

#Preview {
    SignalNotificationsView(
        viewModel: SignalNotificationsViewModel(signalId: "")
    )
}
