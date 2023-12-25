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
            Text(answer.text)
                .bold()
                .foregroundStyle(.primaryText)
            
            Spacer()
            if qwizManager.answerSelected {
                Image(systemName: (answer.isCorrect ? "checkmark.circle.fill" : "x.circle.fill"))
                    .foregroundStyle(answer.isCorrect ? .green : .red)
            }
        }
        .onAppear {
            print("Ответ в строке: \(answer.text)")
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .foregroundStyle(isSelected ? .gray : .primaryText)
        .background(.customBeige)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: qwizManager.answerSelected ? (answer.isCorrect ? .green : .red) : .gray, radius: 5)
        .onTapGesture {
            if !qwizManager.answerSelected {
                isSelected = true
                qwizManager.selectAnswer(answer: answer)
            }
        }
        .padding(.horizontal)
    }
}

//#Preview {
//    QuizAnswerRow(answer: Answer.example)
//        .environmentObject(QuizManager())
//}
