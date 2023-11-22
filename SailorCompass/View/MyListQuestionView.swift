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
    
    @State private var isShowingDeleteAlert = false
    @State private var isShowingPublishAlert = false
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
                isShowingDeleteAlert = true
            }
        }
        .alert("Are you sure?", isPresented: $isShowingDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                if let offsets = deletionIndexSet {
                    deleteItems(offsets: offsets)
                }
            }
        } message: {
            Text("This question will be deleted permanently.")
        }
        .alert("Are you sure?", isPresented: $isShowingPublishAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Yes") {
                publishTest(test: selectedTest)
            }
        } message: {
            Text("This test will be published permanently, and you won't be able to modify it in the future.")
        }
        .navigationTitle(selectedTest.title)
        .toolbar {
            ToolbarItemGroup {
                if selectedTest.isPublished {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundStyle(.green)
                } else {
                    Button {
                        isShowingPublishAlert = true
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
    }
    
    private func publishTest(test: CDTest) {
        DispatchQueue.global(qos: .background).async {
            let publicTestRecord = CKRecord(recordType: "CDTest")
            publicTestRecord["title"] = test.title
            publicTestRecord["version"] = test.version
            publicTestRecord["questionCount"] = test.qcount
            
            let testRecordID = publicTestRecord.recordID
            
            var recordsToSave: [CKRecord] = [publicTestRecord]
            
            for question in test.questions?.allObjects as? [CDQuestion] ?? [] {
                let questionRecord = CKRecord(recordType: "CDQuestion")
                questionRecord["text"] = question.text
                questionRecord["testTitle"] = test.title
                if let answers = question.answers as? Set<CDAnswer>,
                   let correctAnswer = answers.first(where: { $0.isCorrect }) {
                    questionRecord["correctAnswer"] = correctAnswer.text
                }
                questionRecord["test"] = CKRecord.Reference(recordID: testRecordID, action: .deleteSelf)
                recordsToSave.append(questionRecord)
                
                let questionRecordID = questionRecord.recordID
                
                for answer in question.answers?.allObjects as? [CDAnswer] ?? [] {
                    let answerRecord = CKRecord(recordType: "CDAnswer")
                    answerRecord["text"] = answer.text
                    answerRecord["isCorrect"] = answer.isCorrect
                    answerRecord["question"] = CKRecord.Reference(recordID: questionRecordID, action: .deleteSelf)
                    recordsToSave.append(answerRecord)
                }
            }
            
            let modifyRecordsOperation = CKModifyRecordsOperation(recordsToSave: recordsToSave, recordIDsToDelete: nil)
            modifyRecordsOperation.modifyRecordsResultBlock = { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(_):
                        self.viewContext.performAndWait {
                            test.isPublished = true
                            self.saveContext()
                        }
                    case .failure(let error):
                        print("Error saving to public database: \(error)")
                    }
                }
            }
            
            CKContainer.default().publicCloudDatabase.add(modifyRecordsOperation)
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
        //        showingAlert = true
        for index in offsets {
            let question = questions[index]
            selectedTest.qcount -= 1
            viewContext.delete(question)
        }
        saveContext()
    }
}


#Preview {
    QuestionListView(selectedTest: CDTest.example)
    //        .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
}

