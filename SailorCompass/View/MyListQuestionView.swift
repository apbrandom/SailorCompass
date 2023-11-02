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
        
        VStack {
            FilteredList(with: selectedTest)
                .environment(\.managedObjectContext, viewContext)
            
        }
        .listStyle(.plain)
        .navigationTitle(selectedTest.title)
        .toolbar() {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationLink(destination: NewQuestionView(selectedTest: selectedTest).environment(\.managedObjectContext, viewContext)) {
                    Image(systemName: Constants.iconName.plus)
                }
            }
        }
    }
}
    //TO DO
//    private func deleteQuestions(offsets: IndexSet) {
//        let questionsToDelete = offsets.map { questions[$0] }
//        questionsToDelete.forEach(viewContext.delete)
//        
//        do {
//            try viewContext.save()
//        } catch {
//            print("Saving failed: \(error)")
//        }
//    }}

#Preview {
    MyListTestsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
