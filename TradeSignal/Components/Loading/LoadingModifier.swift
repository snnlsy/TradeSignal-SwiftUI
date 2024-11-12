//
//  LoadingModifier.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 26.07.2024.
//

import SwiftUI

// MARK: - LoadingModifier

struct LoadingModifier: ViewModifier {
    @Binding var isLoading: Bool

    func body(content: Content) -> some View {
        ZStack {
            content
                .disabled(isLoading)
                .blur(radius: isLoading ? 3 : 0)
            if isLoading {
                LottieView(
                    animationName: "lottie_loading_animation",
                    animationSize: .init(
                        width: UIScreen.screenWidth,
                        height: UIScreen.screenHeight / 4
                    )
                )
            }
        }
    }
}

extension View {
    func loading(_ isLoading: Binding<Bool>) -> some View {
        self.modifier(LoadingModifier(isLoading: isLoading))
    }
}
