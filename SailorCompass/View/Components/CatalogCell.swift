//
//  CatalogCell.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 04.11.2023.
//

import SwiftUI

struct CatalogCell: View {
    let frame = Constants.LayoutMetrics.screen.width
    let icon: String
    let title: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: frame * 0.25)
                
            Text(title)
        }
        .frame(width: frame * 0.3, height: frame * 0.3)
        .background(RadialGradient(colors: [.clear, .myGlass], center: .center, startRadius: 1, endRadius: 100))
        .clipShape(.rect(cornerRadius: 16))
        .blur(radius: 0.1)
        .shadow(radius: 4)
    }
}

#Preview {
    CatalogCell(icon: "externaldrive.badge.person.crop", title: "My Tests")
}
