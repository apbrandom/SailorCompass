//
//  ContentView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import SwiftUI

struct MyListTestsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: CDTest.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDTest.creationDate_, ascending: true)],
        animation: .default
    ) 
    
    var tests: FetchedResults<CDTest>

    var body: some View {
        List {
            ForEach(tests) { test in
                NavigationLink(destination: QuestionListView(selectedTest: test).environment(\.managedObjectContext, viewContext)) {
                    TestRowView(test: test)
                }
            }
            .onDelete { offsets in
                deleteTests(offsets: offsets, tests: tests)
            }
        }
        .navigationTitle("My Tests")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                NavigationLink(destination: NewTestView().environment(\.managedObjectContext, viewContext)) {
                        Image(systemName: "plus")
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

//#Preview {
//    MyListTestsView(tests: FetchRequest<CDTest>)
//}
