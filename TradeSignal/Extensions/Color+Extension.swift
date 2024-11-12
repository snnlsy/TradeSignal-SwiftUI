//
//  Color+Extension.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 24.05.2024.
//

import SwiftUI

// MARK: - Color Extension

extension Color {
    
    /// Access to the custom color theme.
    static let theme = ColorTheme()
    
    /// Converts `Color` to `UIColor`.
    var uiColor: UIColor {
        UIColor(self)
    }
    
    /// Initializes `Color` with a hexadecimal integer.
    ///
    /// - Parameter hex: An integer representing the color in hexadecimal format (e.g., 0xFF0000 for red).
    init(hex: Int) {
        self.init(hexWithAlpha: (hex << 8) | 0xff)
    }
    
    /// Initializes `Color` with a hexadecimal integer including alpha.
    ///
    /// - Parameter hexWithAlpha: An integer representing the color in hexadecimal format including alpha (e.g., 0xFF0000FF for red with full opacity).
    init(hexWithAlpha: Int) {
        let components = (
            r: Double((hexWithAlpha >> 24) & 0xff) / 255,
            g: Double((hexWithAlpha >> 16) & 0xff) / 255,
            b: Double((hexWithAlpha >> 08) & 0xff) / 255,
            a: Double((hexWithAlpha >> 00) & 0xff) / 255
        )
        self.init(
            red: components.r,
            green: components.g,
            blue: components.b,
            opacity: components.a
        )
    }
}
