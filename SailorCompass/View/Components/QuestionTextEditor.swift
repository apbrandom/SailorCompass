//
//  QuestionTextField.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 09.11.2023.
//

import SwiftUI

struct QuestionTextEditor: View {
    @Binding var text: String
    @Binding var isInvalid: Bool
    let maxLength: Int = 150
    
    var body: some View {
        TextEditor(text: $text)
            .frame(height: 150)
            .textFieldStyle(.roundedBorder)
            .border(isInvalid ? Color.red : Color.clear, width: isInvalid ? 2 : 0)
            .onChange(of: text) { newValue in
                if newValue.count > maxLength {
                    text = String(newValue.prefix(maxLength))
                }
            }
    }
}

#Preview {
    QuestionTextEditor(text: .constant("Qusetion Text Example"), isInvalid: .constant(false))
}
