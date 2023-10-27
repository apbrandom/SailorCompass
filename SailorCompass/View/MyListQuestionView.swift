//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import SwiftUI
import CoreData

struct QuestionListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    var selectedTest: CDTest
    
    @FetchRequest(
        entity: CDQuestion.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDQuestion.text, ascending: true)],
        predicate: nil,
        animation: .default
    )
    private var fetchRequest: FetchedResults<CDQuestion>
    
    private var questions: [CDQuestion] {
        fetchRequest.filter { $0.test == selectedTest }
    }
    
    var body: some View {
        List {
            ForEach(questions) { question in
                Text(question.text ?? "No Question Name")
            }
            .onDelete(perform: deleteQuestions)
        }
        .navigationTitle("Question")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationLink(destination: NewQuestionView(selectedTest: selectedTest)
                                .environment(\.managedObjectContext, viewContext)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    
    private func addQuestion() {
        let newQuestion = CDQuestion(context: viewContext)
        newQuestion.text = "New Question"
        newQuestion.test = selectedTest
        saveContext()
    }
    
    private func deleteQuestions(offsets: IndexSet) {
        offsets.map { questions[$0] }.forEach(viewContext.delete)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Saving failed: \(error)")
        }
    }
}


//
//
//#Preview {
//    MyListQuestionView(viewModel: MyListQuestionViewModel(selectedTest: Test(), questions: Question(), context: PersistenceController.preview.container.viewContext))
//}
