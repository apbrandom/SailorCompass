//
//  QuizTitle.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import SwiftUI


struct QuizTitle: View {

    @Binding var questionIndex: Int
    @Binding var questionLenght: Int
    @Binding var testTitle: String

    var body: some View {
        HStack {
            Text(testTitle)
            Spacer()
            Text("\(questionIndex + 1) out of \(questionLenght)")
        }
        .font(.title2)
        .bold()
        .foregroundStyle(.primaryText)
        .padding()
    }
}

#Preview {
    QuizTitle(questionIndex: .constant(0), questionLenght: .constant(10), testTitle: .constant("Test Title"))
}
