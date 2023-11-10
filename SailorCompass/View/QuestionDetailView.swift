//
//  QuestionDetailView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 30.10.2023.
//

import SwiftUI

struct QuestionDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @ObservedObject var question: CDQuestion
    
    @FetchRequest var answers: FetchedResults<CDAnswer>
    
    init(question: CDQuestion) {
            self.question = question
            self._answers = FetchRequest<CDAnswer>(
                entity: CDAnswer.entity(),
                sortDescriptors: [],
                predicate: NSPredicate(format: "question == %@", question)
            )
        }
    
    var body: some View {
            List {
                Section(header: Text("Question")) {
                    Text(question.text)
                        .font(.headline)
                }

                Section(header: Text("Answers")) {
                    ForEach(answers, id: \.self) { answer in
                        HStack {
                            Text(answer.text)
                        }
                    }
                }
            }
            .navigationTitle("Question Details")
            .navigationBarTitleDisplayMode(.inline)
        }
    
}

#Preview {
    QuestionDetailView(question: CDQuestion.example)
}
