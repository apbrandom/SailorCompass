//
//  MyListTestsViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import Foundation
import CoreData
import SwiftUI

class MyListTestsViewModel: ObservableObject {
    @Published var tests: [Test] = []
    private var viewContext: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.viewContext = context
        fetchTests()
    }

    private func fetchTests() {
        let fetchRequest: NSFetchRequest<Test> = Test.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Test.timestamp, ascending: true)]

        do {
            self.tests = try viewContext.fetch(fetchRequest)
        } catch {
            print("Fetching failed: \(error)")
        }
    }

    func addTest() {
        let newTest = Test(context: viewContext)
        newTest.timestamp = Date()

        do {
            try viewContext.save()
            fetchTests() 
        } catch {
            print("Saving failed: \(error)")
        }
    }

    func deleteTests(offsets: IndexSet) {
        offsets.map { tests[$0] }.forEach(viewContext.delete)

        do {
            try viewContext.save()
            fetchTests() // Update the UI
        } catch {
            print("Deleting failed: \(error)")
        }
    }
    
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
    //    formatter.timeStyle = .medium
        return formatter
    }()
}
