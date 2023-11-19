//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import SwiftUI
import CoreData
import CloudKit

struct QuestionListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var selectedTest: CDTest
    
    @FetchRequest var questions: FetchedResults<CDQuestion>
    
    @State private var showingAlert = false
    @State private var deletionIndexSet: IndexSet?
    
    init(selectedTest: CDTest) {
        self.selectedTest = selectedTest
        let sortDescriptor = NSSortDescriptor(keyPath: \CDQuestion.dateCreated, ascending: true)
        let predicate = NSPredicate(format: "test == %@", selectedTest)
        _questions = FetchRequest<CDQuestion>(sortDescriptors: [sortDescriptor], predicate: predicate)
    }
    
    var body: some View {
        List {
            ForEach(questions, id: \.self) { question in
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
            ToolbarItemGroup {
                Button {
                    publishTest(test: selectedTest)
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                NavigationLink(destination: NewQuestionView(selectedTest: selectedTest)) {
                    Image(systemName: "plus")
                }
                EditButton()
            }
        }
    }
    
    private func publishTest(test: CDTest) {
        let publicTestRecord = CKRecord(recordType: "CDTest")
        publicTestRecord["title"] = test.title
        // ... установите другие атрибуты теста ...
        
        CKContainer.default().publicCloudDatabase.save(publicTestRecord) { record, error in
            if let error = error {
                print("Error saving to public database: \(error)")
            } else {
                viewContext.performAndWait {
                    test.isPublished = true
                    saveContext()
                }
            }
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        showingAlert = true
        for index in offsets {
            let test = questions[index]
            viewContext.delete(test)
        }
        saveContext()
    }
}


#Preview {
    QuestionListView(selectedTest: CDTest.example)
    //        .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
}

