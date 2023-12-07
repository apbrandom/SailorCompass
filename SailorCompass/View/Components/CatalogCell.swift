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
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 10))
                .shadow(color: .black.opacity(0.3), radius: 10)
                .padding(.horizontal)
                .padding(.vertical, 5)
        }
    }
}

#Preview {
    CatalogCell(icon: "externaldrive.badge.person.crop", title: "Saved Tests")
}
