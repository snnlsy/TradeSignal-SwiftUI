//
//  StringLocalizable.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 24.05.2024.
//

import SwiftUI

// MARK: - StringLocalizable

protocol StringLocalizable {
    var localized: String { get }
}

// MARK: - Variable Implementations

extension StringLocalizable where Self: RawRepresentable, Self.RawValue == String {
    
    var localized: String {
        NSLocalizedString(rawValue, comment: "")
    }
}
