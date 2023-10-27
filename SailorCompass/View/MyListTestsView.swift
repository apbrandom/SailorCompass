//
//  ContentView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import SwiftUI

struct MyListTestsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel: MyListTestsViewModel

    @FetchRequest(
        entity: CDTest.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \CDTest.timestamp, ascending: true)],
        animation: .default
    ) 
    var tests: FetchedResults<CDTest>

    var body: some View {
        List {
            ForEach(tests) { test in
                NavigationLink(destination: QuestionListView(selectedTest: test).environment(\.managedObjectContext, viewContext)) {
                    Text(test.title ?? "Unnamed Test")
                    Text(test.timestamp ?? Date(), formatter: viewModel.itemFormatter)
                }
            }
            .onDelete { offsets in
                viewModel.deleteTests(offsets: offsets, tests: tests)
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
}

#Preview {
    MyListTestsView(viewModel: MyListTestsViewModel(context: PersistenceController.preview.container.viewContext))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
