//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import CoreData
import SwiftUI

    class MyListQuestionViewModel: ObservableObject {
        
        
        
        
//        var selectedTest: CDTest
//        @Published var viewContext: NSManagedObjectContext
//       
//        init(selectedTest: CDTest, context: NSManagedObjectContext) {
//            self.selectedTest = selectedTest
//            self.viewContext = context
//        }
//
//    func addQuestion() {
//        let newQuestion = CDQuestion(context: viewContext)
//        newQuestion.text = ""
//        newQuestion.test = selectedTest
//        do {
//            try viewContext.save()
//        } catch {
//            print("Saving question failed: \(error)")
//        }
//    }
//
//    func deleteQuestion(offsets: IndexSet, questions: FetchedResults<CDQuestion>) {
//        offsets.map { questions[$0] }.forEach(viewContext.delete)
//
//        do {
//            try viewContext.save()
//        } catch {
//            print("Deleting question failed: \(error)")
//        }
//    }
}
