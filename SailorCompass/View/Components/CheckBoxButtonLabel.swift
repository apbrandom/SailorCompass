//
//  CheckBoxView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 30.10.2023.
//

import SwiftUI

struct CheckBoxButtonLabel: View {
    
//    var isCorrect: Bool
    
    var body: some View {
        Image(systemName: "checkmark.square" )
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(.mint)
    }
}

#Preview {
    CheckBoxButtonLabel()
}
