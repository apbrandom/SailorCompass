//
//  PlusMinusButtonLabel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 19.12.2023.
//

import SwiftUI

struct PlusMinusButtonLabel: View {
    
    var systemImageName: String
    var color: Color
    
    var body: some View {
        Image(systemName: systemImageName)
            .frame(width: 30, height: 30)
            .bold()
            .foregroundStyle(color)
    }
}

//#Preview {
//    PlusMinusButtonLabel(systemImageName: "minus", color: .red)
//}
