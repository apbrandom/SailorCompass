//
//  QuestionListView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.12.2023.
//

import SwiftUI


struct QuestionRowView: View {
    
    @ObservedObject var question: Question
    
    @FetchRequest var correctAnswers: FetchedResults<Answer>

    init(question: Question) {
        self.question = question
        self._correctAnswers = FetchRequest<Answer>(
            entity: Answer.entity(),
            sortDescriptors: [], // Укажите здесь нужные сортировки, если они требуются
            predicate: NSPredicate(format: "question == %@ AND isCorrect == true", question)
        )
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .multilineTextAlignment(.leading)
            ForEach(correctAnswers, id: \.self) { answer in
                Text(answer.text)
                    .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.secondary)
            }
        }
    }
}

#Preview {
    QuestionRowView(question: Question.example)
}
