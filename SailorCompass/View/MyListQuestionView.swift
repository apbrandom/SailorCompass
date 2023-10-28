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
    
    @FetchRequest(fetchRequest: CDQuestion.fetch(), animation: .bouncy)
    
    private var fetchRequest: FetchedResults<CDQuestion>
    
    private var questions: [CDQuestion] {
        fetchRequest.filter { $0.test == selectedTest }
    }
    
    var body: some View {
        List {
            ForEach(questions) { question in
                QuestionRowView(question: question)
            }
            .onDelete(perform: deleteQuestions)
        }
        .navigationTitle(selectedTest.title)
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

#Preview {
    MyListTestsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
