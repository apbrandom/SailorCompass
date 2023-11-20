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
    //    @State private var selectedTest: CDTest? = nil
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
            ToolbarItemGroup {
                EditButton()
                NavigationLink(destination: NewTestView()) {
                    Image(systemName: Constants.icon.plus)
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        showingAlert = true
        for index in offsets {
            let test = tests[index]
            viewContext.delete(test)
        }
        saveContext()
    }
    
    
    
    //    private func showPublishDialog() {
    //        let options = tests.map { test in
    //            Alert.Button.default(Text(test.title)) {
    //                self.selectedTest = test
    //                self.showingPublishConfirmation = true
    //            }
    //        }
    //
    //        let cancel = Alert.Button.cancel()
    //
    //        let alert = Alert(title: Text("Select Test to Publish"),
    //                          message: Text("Please select a test you want to publish.")
    //                          )
    //
    //        showAlert(alert: alert)
    //    }
    
    //    private func showAlert(alert: Alert) {
    //        // Установите параметры для отображения пользовательского Alert
    //        // Например, установите состояние, которое контролирует, когда Alert должен быть показан
    //    }
    
    
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
