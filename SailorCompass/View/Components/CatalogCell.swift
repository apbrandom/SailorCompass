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
                HStack {
                    Image(systemName: icon)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: frame * 0.25)
                    Text(title)
                    Spacer()
                }
                .frame(height: 100)
                //        .background(RadialGradient(colors: [.indigo, .orange], center: .center, startRadius: 1, endRadius: 100))
                .clipShape(.rect(cornerRadius: 16))
                .shadow(radius: 2)
                .padding()
        }
    }
}

#Preview {
    CatalogCell(icon: "externaldrive.badge.person.crop", title: "My Tests")
}
