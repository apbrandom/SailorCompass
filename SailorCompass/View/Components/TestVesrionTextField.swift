//
//  TextFiledTestVesrion.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 02.11.2023.
//

import SwiftUI

struct TestVesrionTextField: View {
    
    @Binding var text: String
    @Binding var isInvalid: Bool
    
    let placeholder = "Enter Test version"
    let maxLength: Int = 5
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(.roundedBorder)
            .border(isInvalid ? Color.red : Color.clear, width: isInvalid ? 2 : 0)
            .keyboardType(.decimalPad)
            .onChange(of: text) { newValue in
                let replaced = newValue.replacingOccurrences(of: ",", with: ".")
                if replaced.count > maxLength {
                    text = String(replaced.prefix(maxLength))
                } else {
                    text = replaced
                }
            }
    }
}

#Preview {
    TestVesrionTextField(text: .constant(""), isInvalid: .constant(false))
}
