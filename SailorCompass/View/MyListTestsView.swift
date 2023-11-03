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
                deleteTests(offsets: offsets, tests: tests)
            }
        }
        .listStyle(.plain)
        .navigationTitle(Constants.LocalizedStrings.myTests)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationLink(destination: NewTestView().environment(\.managedObjectContext, viewContext)) {
                    Image(systemName: Constants.iconName.plus)
                }
            }
        }
    }
    
    
    func deleteTests(offsets: IndexSet, tests: FetchedResults<CDTest>) {
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
