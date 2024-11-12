//
//  MarketplaceToolBarView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 1.06.2024.
//

import SwiftUI
import Combine

// MARK: - MarketplaceToolBarView

struct MarketplaceToolBarView<ViewModel: MarketplaceToolBarViewModeling>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState private var isFocused: Bool
    
    var body: some View {
        HStack {
            titleView
            Spacer()
            itemsView
        }
        .animation(.interactiveSpring, value: viewModel.isSearchActive)
        .frame(height: 44)
        .onAppear(perform: {
            viewModel.configureItemsVisibility()
            viewModel.configureCartIconVisibility()
        })
    }
}

// MARK: - Subviews

private extension MarketplaceToolBarView {
    @ViewBuilder
    var titleView: some View {
        if !viewModel.isSearchActive {
            Text("TradeSignal")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.theme.secondary)
        }
    }
    
    @ViewBuilder
    var itemsView: some View {
        if viewModel.isItemsActive {
            HStack {
                if viewModel.isCartIconVisible {
                    cartIcon
                }
                filterIcon
                HStack {
                    searchIcon
                    activeSearchField
                }
                .onTapGesture { viewModel.activateSearch() }
            }
            .padding(.small)
            .background(viewModel.isSearchActive ? Color.theme.secondaryVariant : .clear)
            .cornerRadius(.medium)
        }
    }
    
    @ViewBuilder
    var cartIcon: some View {
        if !viewModel.isSearchActive {
            Image(systemName: "cart")
                .foregroundColor(viewModel.isSearchActive ? .theme.primaryVariant : .theme.secondary)
                .onTapGesture {
                    viewModel.didTapCartIcon()
                }
                .fullScreenCover(
                    isPresented: $viewModel.isCartViewActive, 
                    onDismiss: {
                        viewModel.configureCartIconVisibility()
                    }
                ) {
                    if let cartViewModel = viewModel.cartViewModel {
                        CartView(viewModel: cartViewModel)
                            .environmentObject(viewModel)
                    }
                }
        }
    }
    
    @ViewBuilder
    var searchIcon: some View {
        if !viewModel.isSearchActive {
            Image(systemName: "magnifyingglass")
                .foregroundColor(viewModel.isSearchActive ? .theme.primaryVariant : .theme.secondary)
        }
    }
    
    @ViewBuilder
    var filterIcon: some View {
        if !viewModel.isSearchActive {
            Button(
                action: {
                    viewModel.didTapFilterIcon()
                }
            ) {
                Image(systemName: "camera.filters")
                    .foregroundColor(viewModel.isSearchActive ? .theme.primaryVariant : .theme.secondary)
            }
            .sheet(isPresented: $viewModel.isFilterSheetActive) {
                MarketplaceFilterView(viewModel: viewModel.filterViewModel)
            }
        }
    }
    
    @ViewBuilder
    var activeSearchField: some View {
        if viewModel.isSearchActive {
            TextField("Search Trader", text: $viewModel.searchText)
                .textFieldStyle(PlainTextFieldStyle())
                .foregroundColor(.theme.primary)
                .focused($isFocused)
                .disableAutocorrection(true)
                .onAppear(perform: focusTextField)
                .overlay(clearButton, alignment: .trailing)
        }
    }
    
    var clearButton: some View {
        Button(action: viewModel.deactivateSearch) {
            Image(systemName: "xmark.circle.fill")
                .foregroundColor(.theme.primaryVariant)
        }
    }
}

// MARK: - Methods

private extension MarketplaceToolBarView {
    func focusTextField() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            isFocused = true
        }
    }
}

// MARK: - Preview

struct ToolBarView_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceToolBarView(viewModel: MarketplaceToolBarViewModel())
            .previewLayout(.sizeThatFits)
    }
}
