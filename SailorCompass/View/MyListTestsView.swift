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
        entity: Test.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Test.timestamp, ascending: true)],
        animation: .default
    ) 
    var tests: FetchedResults<Test>
    
    var body: some View {
        List {
            ForEach(tests) { test in
                NavigationLink(destination: MyListQuestionView(viewModel: MyListQuestionViewModel(selectedTest: test, context: viewContext), selectedTest: test)) {
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
