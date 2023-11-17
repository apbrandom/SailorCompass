//
//  ContentView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import SwiftUI
import CoreData
import CloudKit

struct MyListTestsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: CDTest.fetch(), animation: .bouncy)
  
    var tests: FetchedResults<CDTest>
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var deletionIndexSet: IndexSet?
    @State private var selectedTest: CDTest? = nil
    @State private var isPublishing = false
    @State private var showingPublishConfirmation = false
    
    var body: some View {
        List {
            ForEach(tests, id: \.self) { test in
                NavigationLink {
                    QuestionListView(selectedTest: test)
                } label: {
                    TestRowView(test: test)
                }
            }
            .onDelete { offsets in
                showingAlert = true
                deletionIndexSet = offsets
            }
        }
        .alert("Are you sure?", isPresented: $showingAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let offsets = deletionIndexSet {
                    deleteItems(offsets: offsets)
                }
            }
        } message: {
            Text("This test will be deleted permanently.")
        }
        
        .listStyle(.plain)
        .navigationTitle(Constants.LocalizedStrings.myTests)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()

            }
            
            ToolbarItem {
                Button(action: {
                    if let testToPublish = selectedTest {
                        publishTest(test: testToPublish, context: viewContext)
                    }
                }) {
                    Image(systemName: "paperplane.fill")
                }
            }

            ToolbarItem {
                NavigationLink(destination: NewTestView().environment(\.managedObjectContext, viewContext)) {
                    Image(systemName: Constants.icon.plus)
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            let test = tests[index]
            viewContext.delete(test)
        }
        saveContext()
    }
    
   private func publishTest(test: CDTest, context: NSManagedObjectContext) {
        let publicTestRecord = CKRecord(recordType: "CDTest")
        publicTestRecord["title"] = test.title
        // ... установите другие атрибуты теста ...

        // Сохранение теста в Public Database
        CKContainer.default().publicCloudDatabase.save(publicTestRecord) { record, error in
            if let error = error {
                // Обработка ошибки
                print("Error saving to public database: \(error)")
            } else {
                // Обновление статуса теста в CoreData
                context.performAndWait {
                    test.isPublished = true
                    try? context.save()
                }
            }
        }
    }
    
    private func saveContext() {
            do {
                try viewContext.save()
            } catch {
                print("Error saving context: \(error)")
            }
        }
}

#Preview {
    MyListTestsView()
        .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
}
