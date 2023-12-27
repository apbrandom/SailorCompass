//
//  Qwiz.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import SwiftUI

struct QuizAnswerRow: View {

    @EnvironmentObject var quizManager: QuizManager

    var answer: Answer
//    @State private var isSelected = false
    
    var isSelected: Bool {
        quizManager.selectedAnswer == answer
    }

    var body: some View {
        HStack(spacing: 20) {
            Text(answer.text)
                .bold()
                .foregroundStyle(.primaryText)
            
            Spacer()
            if isSelected {
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
        .shadow(color: isSelected ? (answer.isCorrect ? .green : .red) : .gray, radius: 5)
        .onTapGesture {
            if !quizManager.answerSelected {
                quizManager.selectAnswer(answer: answer)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

#Preview {
    QuizAnswerRow(answer: Answer.example)
        .environmentObject(QuizManager(selectedTest: Test.example))
}
