//
//  SignalDetailView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.08.2024.
//

import SwiftUI

// MARK: - SignalsView

struct SignalDetailView<ViewModel: SignalDetailViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel

    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        configureAppearance()
    }
    
    var body: some View {
        content
            .padding(.horizontal)
            .background(Color.theme.primary)
            .navigationTitle("Signals")
            .toolbar { toolbarContent }
            .loading($viewModel.isLoadingActive)
            .onReceive(viewModel.chartViewModel.$selectedChartModel) { selectedChartModel in
                viewModel.selectedChartModel = selectedChartModel
            }
    }
    
    var content: some View {
        ScrollView {
            chartInfo
            chart
            Spacer(minLength: .medium)
            segmentedPicker
            Spacer(minLength: .medium)
            dateSelection
            Spacer(minLength: .medium)
            details
            Spacer(minLength: .medium)
            addToCart
        }
    }
}

// MARK: - Chart Info

private extension SignalDetailView {
    @ViewBuilder
    var chartInfo: some View {
        HStack {
            if let selectedChartModel = viewModel.selectedChartModel {
                HStack {
                    Text(selectedChartModel.xAxis)
                    Spacer()
                    Text(selectedChartModel.yAxis.description)
                }
            } else {
                Text(" ")
                    .frame(maxWidth: .infinity)
            }
        }
        .foregroundStyle(Color.theme.secondary)
        .padding(.medium)
        .background(Color.theme.primaryVariant)
        .cornerRadius(.medium)
    }
}

// MARK: - Toolbar Content

private extension SignalDetailView {
    @ToolbarContentBuilder
    var toolbarContent: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { viewModel.isStarred.toggle() }) {
                Image(systemName: viewModel.starImageName)
                    .foregroundColor(.theme.secondary)
            }
        }
    }
}

// MARK: - Chart

private extension SignalDetailView {
    var chart: some View {
        VStack(alignment: .leading, spacing: .medium) {
            CoinChartView(viewModel: viewModel.chartViewModel)
                .padding(.large)
                .background(Color.theme.primaryVariant)
                .cornerRadius(.medium)
        }
    }
}

// MARK: - Time Segment

private extension SignalDetailView {
    @ViewBuilder
    var segmentedPicker: some View {
        Picker("", selection: $viewModel.segments) {
            ForEach(StockChartViewModel.TimeRange.allCases, id: \.self) { option in
                Text(option.rawValue)
            }
        }
        .pickerStyle(.segmented)
    }
}

// MARK: - Date Selection

private extension SignalDetailView {
    var dateSelection: some View {
        HStack {
            dateButton(date: $viewModel.startDate, showCalendar: $viewModel.showStartCalendar)
            Image(systemName: "arrowshape.left.arrowshape.right")
                .foregroundStyle(Color.theme.secondary)
            dateButton(date: $viewModel.endDate, showCalendar: $viewModel.showEndCalendar)
        }
    }
    
    func dateButton(date: Binding<Date>, showCalendar: Binding<Bool>) -> some View {
        Button(action: { showCalendar.wrappedValue = true }) {
            Text(date.wrappedValue, style: .date)
                .font(.footnote)
                .foregroundColor(.theme.primaryVariant)
        }
        .popover(isPresented: showCalendar) {
            DatePicker(
                "Select date",
                selection: date,
                displayedComponents: .date
            )
            .datePickerStyle(.graphical)
            .frame(width: 365, height: 365)
            .colorMultiply(Color.theme.secondary)
            .tint(Color.theme.primary)
            .presentationCompactAdaptation(.popover)
        }
        .padding(.small)
        .background(Color.theme.secondary)
        .cornerRadius(.xLarge)
        .onChange(of: date.wrappedValue) { _ in }
    }
}

// MARK: - Add to Cart

private extension SignalDetailView {
    var addToCart: some View {
        Button {
            
        } label: {
            Text("Add To Cart: $434")
                .padding(.horizontal, .small)
                .frame(height: .xHuge)
                .frame(maxWidth: .infinity)
                .foregroundColor(.theme.primaryVariant)
                .cornerRadius(.huge)
        }
        .background(Color.theme.secondary)
        .cornerRadius(.huge)
    }
}

// MARK: - Stock Details

private extension SignalDetailView {
    var details: some View {
        VStack(spacing: .medium) {
            ForEach(viewModel.infoListModel, id: \.self) { infoModel in
                VStack {
                    Section(header: Text(infoModel.title)
                        .font(.headline)
                    ) {
                        ForEach(Array(infoModel.infoMap), id: \.key) { key, value in
                            HStack {
                                Text(key)
                                    .font(.subheadline)
                                Spacer()
                                Text(value)
                                    .font(.subheadline)
                            }
                        }
                    }
                }
                .padding(.medium)
                .foregroundStyle(Color.theme.secondary)
                .background(Color.theme.primaryVariant)
                .cornerRadius(.medium)
            }
        }
    }
}


// MARK: - Configurations

extension SignalDetailView {
    func configureAppearance() {
        UISegmentedControl.appearance().backgroundColor = UIColor(.theme.primaryVariant)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.theme.primary)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.theme.secondary)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.theme.secondary)], for: .normal)
    }
}

// MARK: - Preview

#Preview {
    SignalDetailView(
        viewModel: SignalDetailViewModel(model: .init(id: "test"))
    )
}
