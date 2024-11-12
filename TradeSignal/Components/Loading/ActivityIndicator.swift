//
//  ActivityIndicator.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 25.07.2024.
//

import SwiftUI

// MARK: - ActivityIndicator

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: Bool
    let color: UIColor = UIColor(Color.theme.secondary)
    let style: UIActivityIndicatorView.Style = .large

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView(style: style)
        indicator.color = color
        return indicator
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
