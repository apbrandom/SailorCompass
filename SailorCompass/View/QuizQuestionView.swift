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
    
    var selectedTest: Test
    
    var body: some View {
        VStack {
            Spacer()
            if quizManager.reachedEnd {
                Text("Test completed! Your score: \(quizManager.score)")
                    .padding()
                    .font(.largeTitle)
                Spacer()
                Button {
                    presentationMode.wrappedValue.dismiss()
                    quizManager.reachedEnd = false
                } label: {
                    CustomButtonLabel(text: "OK", isActive: true)
                }
                .padding()
                Spacer()
            } else {
                ScrollView {
                    QuizTitle(questionIndex: quizManager.index, questionLenght: quizManager.length, testTitle: selectedTest.title)
                    Text(quizManager.question)
                        .font(.system(size: 20))
                        .bold()
                        .foregroundStyle(.gray)
                        .padding()
                    
                    ForEach(quizManager.answerChoices, id: \.self) { answer in
                        QuizAnswerRow(answer: answer)
                            .environmentObject(quizManager)
                    }
                    
                    Spacer()
                    Button {
                        quizManager.goToNextQuestion()
                    } label: {
                        CustomButtonLabel(text: "Next", isActive: quizManager.answerSelected)
                            .frame(maxWidth: 250)
                    }
                    .padding()
                    .disabled(!quizManager.answerSelected)
                    Spacer()
                }
            }
        }
        .applyBackground()
    }
}

#Preview {
    QuizQuestionView(selectedTest: Test.example)
        .environmentObject(QuizManager(selectedTest: Test.example))
}
