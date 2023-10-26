//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import CoreData
import SwiftUI

class MyListQuestionViewModel: ObservableObject {
    
    var selectedTest: Test
    
    @Published var viewContext: NSManagedObjectContext
    var questions: FetchRequest<Question>

    init(selectedTest: Test, context: NSManagedObjectContext) {
        self.selectedTest = selectedTest
        self.viewContext = context
    }

    func addQuestion() {
        let newQuestion = Question(context: viewContext)
        newQuestion.text = ""
        newQuestion.test = selectedTest
        do {
            try viewContext.save()
        } catch {
            print("Saving question failed: \(error)")
        }
    }

    func deleteQuestion(offsets: IndexSet, questions: FetchedResults<Question>) {
        offsets.map { questions[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
        } catch {
            print("Deleting question failed: \(error)")
        }
    }
    
}
