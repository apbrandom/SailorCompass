//
//  QuestionDetailView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 30.10.2023.
//

import SwiftUI

struct UserQuestionDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var question: Question
    
    @FetchRequest var answers: FetchedResults<Answer>
    
    init(question: Question) {
        self.question = question
        self._answers = FetchRequest<Answer>(
            entity: Answer.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "question == %@", question)
        )
    }
    
    var body: some View {
        List {
            Section(header: Text("Question")) {
                Text(question.text)
            }
            Section(header: Text("Answers")) {
                ForEach(answers, id: \.self) { answer in
                    HStack {
                        Text(answer.text)
                        Spacer()
                        if answer.isCorrect {
                            Image(systemName: "checkmark.circle")
                                .foregroundStyle(.green)
                        }
                    }
                }
            }
        }
        .navigationTitle("Question Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserQuestionDetailView(question: Question.example)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
