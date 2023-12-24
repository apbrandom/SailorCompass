//
//  Qwiz.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import SwiftUI

struct QuizAnswerRow: View {

    @EnvironmentObject var qwizManager: QuizManager

    var answer: Answer
    @State private var isSelected = false

    var body: some View {
        HStack(spacing: 20) {
            Image(systemName: "circle.fill")
                .font(.caption)
                .foregroundStyle(.primaryText)
            Text(answer.text)
                .bold()
                .foregroundStyle(.primaryText)
            Spacer()
            Image(systemName: answer.isCorrect ? "checkmar.circle.fill" : "x.circle.fill")
                .foregroundStyle(answer.isCorrect ? .green : .red)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(isSelected ? .gray : .primaryText)
        .background(.customBeige)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: qwizManager.answeSelected ? (answer.isCorrect ? .green : .red) : .gray, radius: 5)
        .onTapGesture {
            if !qwizManager.answeSelected {
                isSelected = true
                qwizManager.selectAnswer(answer: answer)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    QuizAnswerRow(answer: Answer.example)
        .environmentObject(QuizManager())
}
