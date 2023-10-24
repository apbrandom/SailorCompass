//
//  ContentView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import SwiftUI

struct MyListTestsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var viewModel = MyListTestsViewModel(context: PersistenceController.shared.container.viewContext)
    
    var body: some View {
        List {
            ForEach(viewModel.tests) { test in
                NavigationLink(destination: Text("Test at \(test.timestamp!, formatter: viewModel.itemFormatter)")) {
                    Text("Test")
                    Text(test.timestamp!, formatter: viewModel.itemFormatter)
                }
            }
            .onDelete(perform: viewModel.deleteTests)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: viewModel.addTest) {
                    Label("", systemImage: "plus")
                }
            }
        }
    }
}

#Preview {
    MyListTestsView(viewModel: MyListTestsViewModel(context: PersistenceController.preview.container.viewContext))
                .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
