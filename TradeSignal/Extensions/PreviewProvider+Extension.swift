//
//  PreviewProvider+Extension.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 4.09.2024.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
         DeveloperPreview.instance
    }
}

class DeveloperPreview {
    static let instance = DeveloperPreview()
    private init() { }
    
    let signalList: [SignalEntity] = [
        .init(signalId: "SignalID1", traderId: "TraderID1", signalName: "SignalName1", traderName: "TraderName1"),
        .init(signalId: "SignalID2", traderId: "TraderID2", signalName: "SignalName2", traderName: "TraderName2"),
        .init(signalId: "SignalID3", traderId: "TraderID3", signalName: "SignalName3", traderName: "TraderName3"),
        .init(signalId: "SignalID4", traderId: "TraderID4", signalName: "SignalName4", traderName: "TraderName4"),
        .init(signalId: "SignalID5", traderId: "TraderID5", signalName: "SignalName5", traderName: "TraderName5"),
    ]
}
