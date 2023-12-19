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
    
    @State private var isEditing = false
    
    init(question: Question) {
        self.question = question
        self._answers = FetchRequest<Answer>(
            entity: Answer.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "question == %@", question)
        )
    }
    
    var body: some View {
        Form {
            Section("Question") {
                if isEditing {
                    TextField("Edit Question", text: $question.text)
                } else {
                    Text(question.text)
                }
            }
            Section("Answers") {
                ForEach(answers, id: \.self) { answer in
                    HStack {
                        if isEditing {
                            TextField("Edit Answer", text: Binding(
                                get: { answer.text },
                                set: { answer.text = $0 }
                            ))
                        } else {
                            Text(answer.text)
                        }
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
        .toolbar {
                    Button(isEditing ? "Done" : "Edit") {
                        isEditing.toggle()
                        if !isEditing {
                            try? viewContext.save()
                        }
                    }
                }
    }
}

#Preview {
    UserQuestionDetailView(question: Question.example)
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
