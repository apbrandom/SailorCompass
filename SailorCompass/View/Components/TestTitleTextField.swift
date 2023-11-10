//
//  TextFiledTestName.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 02.11.2023.
//

import SwiftUI

struct TestTitleTextField: View {
    @Binding var text: String
    @Binding var isInvalid: Bool
    let placeholder = "Enter Test name"
    let maxLength: Int = 30
    
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
    TestTitleTextField(text: .constant(""), isInvalid: .constant(false))
}
