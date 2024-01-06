//
//  TestsToPublicDetailView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 04.12.2023.
//

import SwiftUI
import CloudKit

struct AdminPublicDetailView: View {
    
    var test: CloudTestModel
    
    @State private var questions = [CloudQuestionModel]()
    
    var body: some View {
        List(questions) { question in
            VStack(alignment: .leading) {
                Text(question.text)
                    .padding(.bottom, 2)
                Text(question.correctAnswer)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 2)
            }
        }
        .navigationTitle(test.title)
        .onAppear(perform: fetchQuestions)
        .toolbar {
            ToolbarItemGroup {
            //    if test.isRejected
                Button {
                    approveTest()
                } label: {
                    Image(systemName: "paperplane.fill")
                }
                Button {
                    rejectTest()
                } label: {
                    Image(systemName: "xmark")
                }
                // }
            }
        }
    }
    
    func fetchQuestions() {
        CloudKitManager.shared.fetchQuestions(testID: test.id) { fetchedQuestions in
            self.questions = fetchedQuestions
        }
    }
    
    func approveTest() {
        moveQuestionsToPublicData()
//        updateTestStatus()
    }
    
    func rejectTest() {
        
    }
    
//    func updateTestStatus() {
//            // Изменяем статус теста в CloudKit
//            CloudKitService.shared.updateTestStatus(testID: test.recordID, isPending: !isTestApproved) { success in
//                if success {
//                    // Обновляем локальный статус в CoreData
//                    test.isPending = !isTestApproved
//                    try? test.managedObjectContext?.save()
//                    // Обновляем состояние для обновления UI
//                    isTestApproved.toggle()
//                }
//            }
//        }
    
    func moveQuestionsToPublicData() {
        var newRecords: [CKRecord] = []
        let fetchGroup = DispatchGroup()
        
        // Перебирает вопросы и клонирует их в новый Record Type.
        for question in questions {
            fetchGroup.enter()
            let originalRecordID = question.id
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: originalRecordID) { record, error in
                defer { fetchGroup.leave() }
                if let record = record, error == nil {
                    let newRecord = CloudKitManager.shared.cloneRecord(original: record, to: "PublicQuestion")
                    newRecords.append(newRecord)
                } else {
                    print("Error fetching record: \(String(describing: error))")
                }
            }
        }
        
        // Сохраняет клонированные записи.
        fetchGroup.notify(queue: .main) {
            saveNewRecords(newRecords: newRecords)
        }
    }
    
    func saveNewRecords(newRecords: [CKRecord]) {
        // Создает операцию модификации для сохранения новых записей.
        let modifyOperation = CKModifyRecordsOperation(recordsToSave: newRecords, recordIDsToDelete: nil)
        modifyOperation.modifyRecordsResultBlock = { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("New records successfully saved to the new Record Type")
                case .failure(let error):
                    print("Error in saving new records: \(error)")
                }
            }
        }
        CKContainer.default().publicCloudDatabase.add(modifyOperation)
    }
}
    
//#Preview {
//    AdminPublicDetailView(test: CloudTestModel(record: .init(recordType: "PublicQuestion")))
//}
