//
//  TextFiledTestName.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 02.11.2023.
//

import SwiftUI

struct TextFieldTestName: View {
    @Binding var text: String
    let placeholder = "Enter Test name"
    let maxLength: Int = 30
    
    var body: some View {
        TextField(placeholder, text: $text)
            .textFieldStyle(.roundedBorder)
            .onChange(of: text) { newValue in
                if newValue.count > maxLength {
                    text = String(newValue.prefix(maxLength))
                }
            }
    }
}

#Preview {
    TextFieldTestName(text: .constant(""))
}
