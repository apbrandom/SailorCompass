//
//  QuizAnswerRow.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import SwiftUI

struct QuizQuestionView: View {
    
    @EnvironmentObject var quizManager: QuizManager
    @Environment(\.presentationMode) var presentationMode
    
//    var test: Test
    
    var body: some View {
        VStack(spacing: 15) {
            if quizManager.reachedEnd {
                Text("Test comleted! Your score: \(quizManager.score) из \(quizManager.length)")
                
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    CustomButtonLabel(text: "OK")
                }
                
            } else {
                Text(quizManager.question)
                    .padding(.top, 40)
                    .font(.system(size: 20))
                    .bold()
                    .foregroundStyle(.gray)
                
                ForEach(quizManager.answerChoices, id: \.id) { answer in
                    QuizAnswerRow(answer: answer)
                        .environmentObject(quizManager)
                }
                
                Spacer()
                Button {
                    quizManager.goToNextQuestion()
                } label: {
                    CustomButtonLabel(text: "Next")
                }
                .disabled(!quizManager.answerSelected)
            }
        }
        .applyBackground()
    }
}
//
//#Preview {
//    QuizQuestionView(test: Test.example)
//        .environmentObject(QuizManager(selectedTest: Test.example))
//}
