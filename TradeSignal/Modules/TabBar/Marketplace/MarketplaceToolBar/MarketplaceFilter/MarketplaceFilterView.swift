//
//  MarketplaceFilterView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 20.07.2024.
//

import SwiftUI
import TagCloud

// MARK: - MarketplaceFilterView

struct MarketplaceFilterView<ViewModel: MarketplaceFilterViewModeling>: View {
    @ObservedObject var viewModel: ViewModel
    @State private var sheetHeight: CGFloat = .zero
    
    var body: some View {
        ScrollView {
            VStack(spacing: .large) {
                Spacer()
                filterSection
                sortSection
                Spacer()
            }
            .padding(.horizontal, .large)
            .overlay {
                GeometryReader { geometry in
                    Color.clear.preference(
                        key: InnerHeightPreferenceKey.self,
                        value: geometry.size.height
                    )
                }
            }
            .onPreferenceChange(InnerHeightPreferenceKey.self) { newHeight in
                sheetHeight = newHeight
            }
            .presentationDetents([.height(sheetHeight)])
        }
        .background(Color.theme.primaryVariant)
    }
}

// MARK: - Filter Section

extension MarketplaceFilterView {
    
    private var filterSection: some View {
        VStack(alignment: .leading, spacing: .large) {
            HStack {
                sectionHeader(title: "Filter Options")
                Spacer()
                Button("Reset") {
                    viewModel.reset()
                }
                .foregroundStyle(Color.theme.secondary)                
            }
            TagCloudView(data: viewModel.tags) { tag in
                selectableTag(title: tag, isSelected: viewModel.isTagSelected(tag))
                    .onTapGesture { viewModel.toggleTag(tag) }
            }
            .padding(.leading, -.xSmall)
            Divider().background(Color.theme.secondary)
        }
    }
}

// MARK: - Sort Section

extension MarketplaceFilterView {

    private var sortSection: some View {
        VStack(alignment: .leading, spacing: .large) {
            sectionHeader(title: "Sort Options")
            ForEach(MarketplaceSortOption.allCases, id: \.self) { option in
                radioButton(
                    checked: viewModel.selectedSortOption == option,
                    title: option.rawValue
                ) {
                    viewModel.selectedSortOption = option
                }
            }
        }
    }
    
    private func selectableTag(title: String, isSelected: Bool) -> some View {
        Text(title)
            .foregroundColor(isSelected ? .theme.primary : .theme.secondary)
            .padding(.horizontal, .medium)
            .padding(.vertical, .small)
            .background(
                RoundedRectangle(cornerRadius: .medium)
                    .fill(isSelected ? Color.theme.secondary : Color.theme.primaryVariant)
            )
            .overlay(
                RoundedRectangle(cornerRadius: .medium)
                    .stroke(isSelected ? Color.theme.secondary : Color.theme.primary, lineWidth: 1)
            )
    }
    
    private func radioButton(checked: Bool, title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .foregroundColor(.theme.secondary)
                Spacer()
                Image(systemName: checked ? "largecircle.fill.circle" : "circle")
                    .foregroundColor(.theme.secondary)
            }
            .padding(.horizontal, .large)
            .frame(height: 40)
            .background(Color.theme.primaryVariant)
            .cornerRadius(.medium)
            .overlay(
                RoundedRectangle(cornerRadius: .medium)
                    .stroke(Color.theme.primary, lineWidth: 1)
            )
        }
    }
}

// MARK: - Helper Components

extension MarketplaceFilterView {
    
    private func sectionHeader(title: String) -> some View {
        Text(title)
            .font(.headline)
            .foregroundStyle(Color.theme.secondary)
    }
}
