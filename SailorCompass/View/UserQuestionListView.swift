//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import SwiftUI
import CoreData
import CloudKit

struct UserQuestionListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var selectedTest: Test
    
    @FetchRequest var questions: FetchedResults<Question>
    
    @State private var isShowingDeleteAlert = false
    @State private var isShowingPublishAlert = false
    @State private var deletionIndexSet: IndexSet?
    
    init(selectedTest: Test) {
        self.selectedTest = selectedTest
        let sortDescriptor = NSSortDescriptor(keyPath: \Question.dateCreated, ascending: true)
        let predicate = NSPredicate(format: "test == %@", selectedTest)
        _questions = FetchRequest<Question>(sortDescriptors: [sortDescriptor], predicate: predicate)
    }
    
    var body: some View {
        List {
            ForEach(questions, id: \.self) { question in
                Section {
                    NavigationLink(destination: QuestionDetailView(question: question)) {
                        VStack(alignment: .leading) {
                            Text(question.text)
                                .padding(.bottom, 2)
                            Text(question.correctAnswer)
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .padding(.bottom, 2)
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
    
    private func publishTest(test: Test) {
        DispatchQueue.global(qos: .background).async {
            CKContainer.default().fetchUserRecordID { (recordID, error) in
                guard let userID = recordID, error == nil else {
                    print("Error fetching user record ID: \(String(describing: error))")
                    return
                }
                
                let publicTestRecord = CKRecord(recordType: "PublicTest")
                publicTestRecord["title"] = test.title
                publicTestRecord["version"] = test.version
                publicTestRecord["questionCount"] = test.qcount
                publicTestRecord["UserID"] = userID.recordName
                publicTestRecord["likeCount"] = 0
                let testRecordID = publicTestRecord.recordID
                
                var recordsToSave: [CKRecord] = [publicTestRecord]
                
                for question in test.questions?.allObjects as? [Question] ?? [] {
                    let questionRecord = CKRecord(recordType: "PublicQuestion")
                    questionRecord["text"] = question.text
                    questionRecord["testTitle"] = test.title
                    questionRecord["UserID"] = userID.recordName
                    if let answers = question.answers as? Set<Answer>,
                       let correctAnswer = answers.first(where: { $0.isCorrect }) {
                        questionRecord["correctAnswer"] = correctAnswer.text
                    }
                    
                    questionRecord["test"] = CKRecord.Reference(recordID: testRecordID, action: .deleteSelf)
                    recordsToSave.append(questionRecord)
                    
                    let questionRecordID = questionRecord.recordID
                    
                    for answer in question.answers?.allObjects as? [Answer] ?? [] {
                        let answerRecord = CKRecord(recordType: "PublicAnswer")
                        answerRecord["text"] = answer.text
                        answerRecord["isCorrect"] = answer.isCorrect
                        answerRecord["userID"] = userID.recordName
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
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            let question = questions[index]
            selectedTest.qcount -= 1
            viewContext.delete(question)
        }
        saveContext()
    }
}


#Preview {
    UserQuestionListView(selectedTest: Test.example)
    //            .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
}

