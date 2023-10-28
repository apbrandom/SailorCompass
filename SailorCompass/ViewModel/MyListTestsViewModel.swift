//
//  MyListTestsViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//
//
//import CoreData
//import SwiftUI
//
//class MyListTestsViewModel: ObservableObject {
//    
//    @Published var viewContext: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//        self.viewContext = context
//    }
//
//    func addTest() {
//        let newTest = CDTest(context: viewContext)
//        newTest.timestamp = Date()
//        newTest.title = ""
//        do {
//            try viewContext.save()
//        } catch {
//            print("Saving tests failed: \(error)")
//        }
//    }
//
//    func deleteTests(offsets: IndexSet, tests: FetchedResults<CDTest>) {
//        offsets.map { tests[$0] }.forEach(viewContext.delete)
//
//        do {
//            try viewContext.save()
//        } catch {
//            print("Deleting tests failed: \(error)")
//        }
//    }
//    
//    let itemFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .short
//        return formatter
//    }()
//}
