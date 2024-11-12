//
//  Text+Extension.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 1.09.2024.
//

import SwiftUI

extension Text {
    init(_ value: Int) {
        self.init(value.description)
    }
    
    init(_ value: Double) {
        self.init(value.description)
    }

    init(_ value: Float) {
        self.init(value.description)
    }
    
    init(_ value: CGFloat) {
        self.init(value.description)
    }
}
