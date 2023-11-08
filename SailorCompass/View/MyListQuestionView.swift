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
    
    @FetchRequest var questions: FetchedResults<CDQuestion>
    
    init(selectedTest: CDTest) {
            self.selectedTest = selectedTest
            self._questions = FetchRequest<CDQuestion>(
                entity: CDQuestion.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \CDQuestion.dateCreated, ascending: true)],
                predicate: NSPredicate(format: "test == %@", selectedTest)
            )
        }
    
    var body: some View {
            FilteredQuestionList(with: selectedTest)
                .navigationTitle(selectedTest.title)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem() {
                        NavigationLink(destination: NewQuestionView(selectedTest: selectedTest)) {
                            Label("Добавить вопрос", systemImage: "plus")
                        }
                    }
                }
        }
}

#Preview {
    QuestionListView(selectedTest: CDTest.example)
//        .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
}

