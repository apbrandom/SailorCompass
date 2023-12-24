//
//  ContentView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import SwiftUI

struct SavedListTestsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Test.fetch(), animation: .bouncy)
    
    var tests: FetchedResults<Test>
    
    @StateObject var vm = SavedListTestsViewModel()
    
    var body: some View {
        List {
            ForEach(tests, id: \.self) { test in
                NavigationLink {
                    UserQuestionListView(selectedTest: test)
                } label: {
                    TestRowView(test: test)
                }
                .listRowBackground(Color.clear)
            }
            .onDelete { offsets in
                vm.showingAlert = true
                vm.deletionIndexSet = offsets
            }
            .listRowSeparator(.hidden)
        }
        .alert("Are you sure?", isPresented: $vm.showingAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let offsets = vm.deletionIndexSet {
                    deleteItems(offsets: offsets)
                }
            }
        } message: {
            Text("This test will be deleted permanently.")
        }
        .listStyle(.plain)
        .navigationTitle(Constants.LocalizedStrings.savedTests)
        .toolbar {
            ToolbarItemGroup {
                EditButton()
                NavigationLink {
                    NewTestView()
                } label: {
                    Image(systemName: Constants.icon.plus)
                }
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        vm.showingAlert = true
        for index in offsets {
            let test = tests[index]
            viewContext.delete(test)
        }
        saveContext()
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
    SavedListTestsView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        .applyBackground()
}
