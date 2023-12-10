//
//  CatalogCell.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 04.11.2023.
//

import SwiftUI

struct MainViewCell: View {
    let frame = Constants.LayoutMetrics.screen.width
    let icon: String
    let title: String
    
    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 40, maxHeight: 40)
                        .padding()
                    Text(title)
                    Spacer()
                }
                .frame(height: 100)
                .background(
                    GlassView(removeEffects: true)
                    .blur(radius: 10, opaque: true)
                )
                .clipShape(.rect(cornerRadius: 10))
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(.white.opacity(0.3), lineWidth: 2)
                )
                .shadow(color: .customGrey.opacity(0.3), radius: 3)
                .padding(.horizontal)
                .padding(.vertical, 5)
        }
    }
}

#Preview {
    MainViewCell(icon: "externaldrive.badge.person.crop", title: "Saved Tests")
        .applyBackground()
}
