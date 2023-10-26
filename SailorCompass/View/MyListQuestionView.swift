//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import SwiftUI

struct MyListQuestionView: View {
    
    @ObservedObject var viewModel: MyListQuestionViewModel
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        entity: Question.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Question.text, ascending: true)],
        predicate: NSPredicate(format: "test == %@", viewModel.selectedTest),
        animation: .default
    )
    var questions: FetchedResults<Question>
    
    var body: some View {
        List {
            ForEach(questions) { question in
                Text(question.text ?? "No Question Name")
            }
            .onDelete { offsets in
                viewModel.deleteQuestion(offsets: offsets, questions: questions)
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationLink(destination: NewQuestionView().environment(\.managedObjectContext, viewContext)) {
                        Image(systemName: "plus")
                    }
            }
        }
    }
}

#Preview {
    MyListQuestionView(viewModel: MyListQuestionViewModel(selectedTest: Test(), context: PersistenceController.preview.container.viewContext))
}
