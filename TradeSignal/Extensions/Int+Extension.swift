//
//  Int+Extension.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 19.07.2024.
//

import Foundation

extension Int {
    
    var kFormat: String {
        self < 1000 ? "\(self)" : "\(self/1000)k"
    }
}
