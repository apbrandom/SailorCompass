//
//  ContentView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import SwiftUI

struct MyListTestsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: CDTest.fetch(), animation: .bouncy)
  
    var tests: FetchedResults<CDTest>
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    @State private var deletionIndexSet: IndexSet?
    
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
                NavigationLink(destination: NewTestView().environment(\.managedObjectContext, viewContext)) {
                    Image(systemName: Constants.icon.plus)
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
            offsets.map { tests[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                print("Deleting tests failed: \(error)")
            }
        }
}

#Preview {
    MyListTestsView()
        .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
}
