//
//  GlassView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 07.12.2023.
//

import SwiftUI

struct GlassView: UIViewRepresentable {
    
    var removeEffects = false
    
    func makeUIView(context: Context) -> some UIView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .systemUltraThinMaterial))
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        DispatchQueue.main.async {
            if let sublayer = uiView.layer.sublayers?.first {
                if removeEffects  {
                    sublayer.filters?.removeAll()
                } else {
                    sublayer.filters?.removeAll(where: { filter in
                        String(describing: filter) != "gaussianBlur"
                    })
                }
            }
        }
    } 
}
