//
//  QuizView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import SwiftUI

struct QuizListTestView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Test.fetch(), animation: .bouncy)
    var tests: FetchedResults<Test>
    
    var body: some View {
        List {
            ForEach(tests, id: \.self) { test in
                NavigationLink {
                    QuizQuestionView()
                        .environmentObject(QuizManager(selectedTest: test))
                } label: {
                    TestRowView(test: test)
                }
                .listRowBackground(Color.clear)
            }
            .listRowSeparator(.hidden)
        }
        .navigationTitle("select a test to practice")
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .applyBackground()
    }
}

#Preview {
    QuizListTestView()
        .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
