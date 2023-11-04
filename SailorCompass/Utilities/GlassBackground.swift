//
//  GlassBackground.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 04.11.2023.
//

import SwiftUI

struct GlassBackground: View {
//    let width: CGFloat
//    let height: CGFloat
    let color: Color

    var body: some View {
        ZStack{
            RadialGradient(colors: [.clear, color],
                           center: .center,
                           startRadius: 1,
                           endRadius: 100)
                .opacity(0.6)
            Rectangle().foregroundColor(color)
        }
        .opacity(0.2)
        
        .cornerRadius(10)
//        .frame(width: width, height: height)
    }
}

//#Preview {
//    GlassBackground()
//}
