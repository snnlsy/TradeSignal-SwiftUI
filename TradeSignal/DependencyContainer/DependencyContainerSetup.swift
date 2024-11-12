//
//  DependencyContainerSetup.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 19.08.2024.
//

// MARK: - DependencyContainer Setup

extension DependencyContainer {
    func setupDependencies() {
        register(NetworkServicing.self, lifetime: .singleton) {
            NetworkService()
        }
    }
}
