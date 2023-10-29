//
//  CustomButton.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 29.10.2023.
//

import SwiftUI

struct CustomButtonLabel: View {
    
    var text: String
    
    var body: some View {
        Text(text)
        .padding()
        .frame(maxWidth: .infinity)
        .background(LinearGradient(colors: [.green, .blue], startPoint: .leading, endPoint: .trailing))
        .font(.title3.bold())
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: 10))
        .contentShape(Rectangle())
    }
}
