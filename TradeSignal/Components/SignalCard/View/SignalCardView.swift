//
//  SignalCardView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 1.06.2024.
//

import SwiftUI

// MARK: - SignalCardView

struct SignalCardView<ViewModel: SignalCardViewModeling>: View {
    private let viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    titleView(
                        traderName: viewModel.traderName,
                        signalName: viewModel.signalName
                    )
                    Spacer()
                    switch viewModel.cardType {
                    case .marketplace:
                        addButtonView
                    case .signals:
                        messageCountView
                    }
                }
                propertiesView
            }
        }
        .padding(.medium)
        .background(Color.theme.primaryVariant)
        .frame(width: UIScreen.main.bounds.width - 32)
        .cornerRadius(.small)
    }
}

// MARK: - Title View

extension SignalCardView {
    @ViewBuilder
    private func titleView(traderName: String, signalName: String) -> some View {
        VStack(alignment: .leading) {
            Text(traderName)
                .bold()
            Text(signalName)
        }
        .font(.caption)
        .foregroundColor(.theme.secondary)
    }
}

// MARK: - Add Button View

extension SignalCardView {
    @ViewBuilder
    private var addButtonView: some View {
        Button(action: { viewModel.didTapAddButton() }) {
            VStack(spacing: .xSmall) {
                Image(systemName: "plus")
                    .foregroundColor(.theme.secondary)
                Text(viewModel.price)
                    .foregroundColor(.theme.secondary)
                    .font(.system(size: .medium))
            }
            .padding(.xSmall)
            .frame(width: 50)
        }
        .background(Color.theme.primary)
        .cornerRadius(.small)
    }
}

// MARK: - Message Count View

extension SignalCardView {
    @ViewBuilder
    private var messageCountView: some View {
        Text(viewModel.messageCount)
            .foregroundColor(.theme.secondary)
            .font(.system(size: .medium))
            .padding(.xSmall)
    }
}

// MARK: - Properties View

extension SignalCardView {
    @ViewBuilder
    private var propertiesView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                signalCardPropertyItemView(
                    propertyName: viewModel.gainRate,
                    propertyNameColor: viewModel.propertyNameColor,
                    iconName: viewModel.gainRateIconName
                )
                signalCardPropertyItemView(
                    propertyName: viewModel.subscriberCount,
                    iconName: viewModel.subscriberCountIconName
                )
                signalCardPropertyItemView(
                    propertyName: viewModel.marketType,
                    iconName: viewModel.marketTypeIconName
                )
                signalCardPropertyItemView(
                    propertyName: viewModel.termType,
                    iconName: viewModel.termIconName
                )
            }
        }
    }
    
    @ViewBuilder
    private func signalCardPropertyItemView(
        propertyName: String,
        propertyNameColor: Color = .theme.secondary,
        iconName: String
    ) -> some View {
        HStack(spacing: .xSmall) {
            Image(systemName: iconName)
                .foregroundColor(.theme.secondary)
            Text(propertyName)
                .foregroundColor(propertyNameColor)
        }
        .font(.caption)
        .padding(.horizontal, .small)
        .padding(.vertical, .xSmall)
        .background(Color.theme.primary)
        .cornerRadius(.small)
    }
}

// MARK: - Preview

#Preview {
    SignalCardView(
        viewModel: SignalCardViewModel(
            model: .init(
                traderId: "123",
                signalId: "1234",
                traderName: "Trader Name",
                signalName: "Signal Name",
                price: 29.4,
                signalProperties: .init(
                    gainRate: 23.4,
                    subscriberCount: 118,
                    marketType: .bist,
                    termType: .long
                )
            ),
            propertyIconsModel: .init(
                gainRate: "chart.line.uptrend.xyaxis",
                subscriberCount: "person.3",
                marketType: "calendar",
                term: "clock"
            ),
            cardType: .marketplace,
            toolbarViewModel: MarketplaceToolBarViewModel()
        )
    )
}
