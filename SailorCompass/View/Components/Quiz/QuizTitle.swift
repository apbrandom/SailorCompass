//
//  QuizTitle.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import SwiftUI


struct QuizTitle: View {

     var questionIndex: Int
     var questionLenght: Int
     var testTitle: String

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
    QuizTitle(questionIndex: 0, questionLenght: 1, testTitle: "Test title")
}
