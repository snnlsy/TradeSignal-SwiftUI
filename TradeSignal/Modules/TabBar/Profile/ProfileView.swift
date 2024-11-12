//
//  ProfileView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 24.05.2024.
//

import SwiftUI

// MARK: - ProfileView
struct ProfileView<ViewModel: ProfileViewModeling>: View {
    @ObservedObject private var viewModel: ViewModel
    
    @State var isDarkModeEnabled: Bool = true
    @State var downloadViaWifiEnabled: Bool = false
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
                .loading($viewModel.isLoadingActive)
                .navigationDestination(isPresented: $viewModel.isSubscriptionsViewActive) {
                    if let vm = viewModel.subscriptionsViewModel {
                        SubscriptionsView(viewModel: vm)
                    }
                }
                .navigationDestination(isPresented: $viewModel.isRiskSurveyViewActive) {
                    if let vm = viewModel.riskSurveyViewModel {
                        RiskSurveyView(viewModel: vm)
                    }
                }
        }
    }
}

// MARK: - Content Views

private extension ProfileView {
    var content: some View {
        Form {
            profileSection
            settingsSection
            otherSection
        }
        .foregroundColor(.theme.secondary)
        .scrollContentBackground(.hidden)
        .background(Color.theme.primary)
    }
}

// MARK: - Sections

private extension ProfileView {
    var profileSection: some View {
        Section(
            content: {
                HStack {
                    Text("Sinan Ulusoy")
                }
                HStack {
                    Image(systemName: "mail")
                    Text("test@gmail.com")
                }
                HStack {
                    Image(systemName: "phone")
                    Text("+90 111 222 33 44")
                }
            }
        )
        .listRowSeparatorTint(Color.theme.secondary)
        .listRowBackground(Color.theme.primaryVariant)
    }
    
    var settingsSection: some View {
        Section(
            content: {
                HStack {
                    Image(systemName: "testtube.2")
                    Text("Risk Anketi")
                }
                .onTapGesture {
                    viewModel.didTapRiskSurvey()
                }
                HStack {
                    Image(systemName: "dot.radiowaves.up.forward")
                    Text("Abonelikler")
                }
                .onTapGesture {
                    viewModel.didTapSubscriptions()
                }
                HStack{
                    Image(systemName: "creditcard")
                    Text("Kayitli Kartlar")
                }
            }
        )
        .listRowSeparatorTint(Color.theme.secondary)
        .listRowBackground(Color.theme.primaryVariant)
    }
    
    var otherSection: some View {
        Section(
            content: {
                HStack {
                    Image(systemName: "circle.hexagonpath")
                    Text("Tanitim")
                }
                HStack{
                    Image(systemName: "books.vertical")
                    Text("Hakkinda")
                }
                HStack{
                    Image(systemName: "pip.exit")
                    Text("Cikis")
                }
            }
        )
        .listRowSeparatorTint(Color.theme.secondary)
        .listRowBackground(Color.theme.primaryVariant)
    }
}


#Preview {
    ProfileView(
        viewModel: ProfileViewModel()
    )
}
