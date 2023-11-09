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

