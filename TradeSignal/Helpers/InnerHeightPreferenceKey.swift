//
//  InnerHeightPreferenceKey.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 23.07.2024.
//

import SwiftUI

struct InnerHeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
