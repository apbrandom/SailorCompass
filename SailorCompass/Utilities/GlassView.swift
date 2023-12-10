//
//  GlassView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 07.12.2023.
//

import SwiftUI

struct GlassView: UIViewRepresentable {
    
    var removeEffects = false
    @Environment(\.colorScheme) var colorScheme
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        if removeEffects {
            uiView.effect = nil
        } else {
            uiView.effect = UIBlurEffect(style: .systemUltraThinMaterial)
        }
    }
}

