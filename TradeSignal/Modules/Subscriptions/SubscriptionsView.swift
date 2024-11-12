//
//  SubscriptionsView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

import SwiftUI

struct SubscriptionsView<ViewModel: SubscriptionsViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.theme.primary
            content
        }
        .padding(.horizontal)
        .background(Color.theme.primary)
        .navigationTitle("Subscriptions")
        .navigationBarTitleDisplayMode(.inline)
        .loading($viewModel.isLoadingActive)
    }
    
    var content: some View {
        VStack {
            segmentedPicker
            subscriptionList
            Spacer()
        }
    }
}

private extension SubscriptionsView {
    var segmentedPicker: some View {
        Picker("", selection: $viewModel.subscriptionStatusType) {
            ForEach(SubscriptionsSegments.allCases, id: \.self) { status in
                Text(status.rawValue)
            }
        }
        .pickerStyle(.segmented)
        .padding(.vertical, .large)
        .onChange(of: viewModel.subscriptionStatusType) { newValue in
            viewModel.didPickerChangeValue()
        }
    }
    
    var subscriptionList: some View {
        ScrollView {
            LazyVStack(spacing: .small) {
                ForEach(viewModel.selectedSubscriptionsList, id: \.self) { subscription in
                    subscriptionView(with: subscription)
                        .padding(.vertical, .xSmall)
                }
            }
        }
    }
    
    func subscriptionView(with model: SubscriptionsModel) -> some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("Status:")
                        .bold()
                    Spacer()
                    Text(model.status.rawValue)
                }
                HStack {
                    Text("Trader Name:")
                        .bold()
                    Spacer()
                    Text(model.traderName)
                }
                HStack {
                    Text("Singal Name:")
                        .bold()
                    Spacer()
                    Text(model.signalName)
                }
                HStack {
                    Text("Start Date:")
                        .bold()
                    Spacer()
                    Text(model.startDate)
                }
                if let endDate = model.endDate {
                    HStack {
                        Text("End Data:")
                            .bold()
                        Spacer()
                        Text(endDate)
                    }
                }
                if model.status != .expired {
                    cancelButton(with: model)
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding(.medium)
        .font(.callout)
        .background(model.status == .pending ? Color.white.opacity(0.3) : Color.theme.primaryVariant)
        .foregroundColor(.theme.secondary)
        .cornerRadius(.medium)
    }
    
    func cancelButton(with model: SubscriptionsModel) -> some View {
        Button(
            action: {
                viewModel.didTapCancelButton(model: model)
            },
            label: {
                Text("Cancel Subscription")
                    .frame(maxWidth: .infinity)
                    .padding(.xSmall)
                    .background(Color.theme.secondary)
                    .foregroundColor(.theme.primary)
                    .cornerRadius(.huge)
            }
        )
    }
}

