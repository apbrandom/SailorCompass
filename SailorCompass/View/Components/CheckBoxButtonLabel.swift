//
//  CheckBoxView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 30.10.2023.
//

import SwiftUI

struct CheckBoxButtonLabel: View {
    
    let isCorrect: Bool
    
    var body: some View {
        Image(systemName: isCorrect ? "checkmark.square" : "square")
            .resizable()
            .frame(width: 30, height: 30)
            .foregroundColor(isCorrect ? .mint : .gray)
    }
}

//#Preview {
//    CheckBoxView(checked: true)
//}
