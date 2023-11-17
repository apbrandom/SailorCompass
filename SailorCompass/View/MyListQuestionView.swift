//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import SwiftUI
import CoreData

struct QuestionListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var selectedTest: CDTest
    
    @FetchRequest var fetchRequest: FetchedResults<CDQuestion>
    
    @State private var showingAlert = false
    @State private var deletionIndexSet: IndexSet?
    
    init(selectedTest: CDTest) {
        self.selectedTest = selectedTest
        let sortDescriptor = NSSortDescriptor(keyPath: \CDQuestion.dateCreated, ascending: true)
        let predicate = NSPredicate(format: "test == %@", selectedTest)
        _fetchRequest = FetchRequest<CDQuestion>(sortDescriptors: [sortDescriptor], predicate: predicate)
    }

    var body: some View {
        List {
            ForEach(fetchRequest, id: \.self) { question in
                Section {
                    NavigationLink(destination: QuestionDetailView(question: question)) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(question.text)
                                .font(.headline)
                            Divider()
                            ForEach(question.sortedAnswers, id: \.self) { answer in
                                HStack {
                                    Text(answer.text)
                                }
                            }
                        }
                    }
                }
            }
            .onDelete { offsets in
                deletionIndexSet = offsets
                showingAlert = true 
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
            Text("This question will be deleted permanently.")
        }
        .navigationTitle(selectedTest.title)
        .toolbar {
            ToolbarItem() {
                NavigationLink(destination: NewQuestionView(selectedTest: selectedTest)) {
                    Label("Добавить вопрос", systemImage: "plus")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fetchRequest[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


#Preview {
    QuestionListView(selectedTest: CDTest.example)
//        .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
}

