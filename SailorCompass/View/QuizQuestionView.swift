//
//  QuizAnswerRow.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import SwiftUI

struct QuizQuestionView: View {
    
    @EnvironmentObject var quizManager: QuizManager
    
    var body: some View {
        VStack(spacing: 15) {

            
//            QwizProgressBar(progress: qwizManager.progress)
           
            Text(quizManager.question)
                .padding(.top, 40)
                .font(.system(size: 20))
                .bold()
                .foregroundStyle(.gray)
            Spacer()
            
            ForEach(quizManager.answerChoices, id: \.id) { answer in
                QuizAnswerRow(answer: answer)
                    .environmentObject(quizManager )
            }
            
            Button {
                quizManager.goToNextQuestion()
            } label: {
                CustomButtonLabel(text: "Next")
            }
            .disabled(!quizManager.answeSelected)
        }
        .applyBackground()
    }
}

#Preview {
    QuizQuestionView()
}
