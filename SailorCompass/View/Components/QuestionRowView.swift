//
//  QuestionRowView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 28.10.2023.
//

import SwiftUI

struct QuestionRowView: View {
    
    @ObservedObject var question: CDQuestion
    
    @FetchRequest(fetchRequest: CDAnswer.fetch(), animation: .bouncy)
    private var correctAnswers: FetchedResults<CDAnswer>
    
    private var correctAnswersForQuestion: [CDAnswer] {
        correctAnswers.filter { $0.question == question && $0.isCorrect }
    }
    
    var body: some View {
        VStack {
            Text(question.text)
            ForEach(correctAnswersForQuestion, id: \.self) { answer in
                Text(answer.text)
                    .foregroundStyle(.mint)
            }
            
        }
    }
}
    #Preview {
        QuestionRowView(question: CDQuestion.example)
    }
