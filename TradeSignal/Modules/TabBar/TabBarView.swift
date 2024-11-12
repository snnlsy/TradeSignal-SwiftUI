//
//  ContentView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 24.05.2024.
//

import SwiftUI

// MARK: - TabBarView

struct TabBarView: View {
    @StateObject private var sendSignalViewModel = SendSignalViewModel(signalList: DeveloperPreview.instance.signalList)
    @StateObject private var marketplaceViewModel = MarketplaceViewModel()
    @StateObject private var signalsViewModel = SignalsViewModel()
    @StateObject private var profileViewModel = ProfileViewModel()

    var body: some View {
        TabView {
            MarketplaceView(viewModel: marketplaceViewModel)
                .tabItem {
                    Label(
                        LocaleKey.marketplaceTitle.localized,
                        systemImage: ImageConstant.TabBar.marketplace
                    )
                }
            SignalsView(viewModel: signalsViewModel)
                .tabItem {
                    Label(
                        LocaleKey.signalsTitle.localized,
                        systemImage: ImageConstant.TabBar.signals
                    )
                }
            ProfileView(viewModel: profileViewModel)
                .tabItem {
                    Label(
                        LocaleKey.profileTitle.localized,
                        systemImage: ImageConstant.TabBar.profile
                    )
                }
            SendSignalView(viewModel: sendSignalViewModel)
                .tabItem {
                    Label(
                        LocaleKey.sendSignalTitle.localized,
                        systemImage: ImageConstant.TabBar.sendSignal
                    )
                }
        }
        .tint(Color.theme.secondary)
        .onAppear {
            setupAppearance()
        }
    }
}

// MARK: - UI Configuration

private extension TabBarView {
    
    func setupAppearance() {
        // MARK: - UINavigationBarAppearance
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        navigationBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.theme.secondary)]
        navigationBarAppearance.backgroundColor = UIColor(Color.theme.primary)
        navigationBarAppearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000, vertical: 0)
        navigationBarAppearance.shadowColor = nil
        
        UINavigationBar.appearance().standardAppearance = navigationBarAppearance
        UINavigationBar.appearance().compactAppearance = navigationBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

        // MARK: - UITabBarAppearance

        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBarAppearance.configureWithOpaqueBackground()
        tabBarAppearance.backgroundColor = UIColor(Color.theme.primary)
        tabBarAppearance.shadowColor = nil

        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        UITabBar.appearance().standardAppearance = tabBarAppearance
    }
}

// MARK: - Preview

#Preview {
    TabBarView()
}
