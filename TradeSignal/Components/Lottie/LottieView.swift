//
//  LottieView.swift
//  TradeSignal
//
//  Created by Sinan Ulusoy on 3.09.2024.
//

import SwiftUI
import Lottie

struct LottieView: UIViewRepresentable {
    let animationName: String
    var loopMode: LottieLoopMode = .loop
    var animationSpeed: CGFloat = 1.0
    var contentMode: UIView.ContentMode = .scaleAspectFit
    var animationSize: CGSize
    
    private let animationView = LottieAnimationView()

    func makeUIView(context: Context) -> UIView {
        animationView.animation = .named(animationName)
        animationView.contentMode = contentMode
        animationView.loopMode = loopMode
        animationView.animationSpeed = animationSpeed
        animationView.play()
        animationView.translatesAutoresizingMaskIntoConstraints = false

        let view = UIView(frame: .zero)
        view.addSubview(animationView)
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalToConstant: animationSize.width),
            animationView.heightAnchor.constraint(equalToConstant: animationSize.height),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
    }
}
