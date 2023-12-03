//
//  AnswerTextField.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 09.11.2023.
//

import SwiftUI

struct AnswerTextField: View {
    
    @Binding var text: String
    @Binding var isInvalid: Bool
    
    let placeholder = "Answer"
    let maxLength: Int = 120
    
    var body: some View {
        TextField(placeholder, text: $text)
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
    AnswerTextField(text: .constant("Answer Text Example"), isInvalid: .constant(false))
}
