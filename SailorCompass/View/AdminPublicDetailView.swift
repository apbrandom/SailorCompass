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
            Button("Move Questions", action: moveQuestionsToNewRecordType)
        }
    }
    
    // Загружает вопросы из CloudKit, соответствующие данному тесту.
    func fetchQuestions() {
        let predicate = NSPredicate(format: "test == %@", test.id)
        let query = CKQuery(recordType: "AdminPublicQuestion", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        
        // Обрабатывает каждую успешно полученную запись и добавляет вопросы в список.
        queryOperation.recordMatchedBlock = { (_, result) in
            switch result {
            case .success(let record):
                let question = CloudQuestionModel(record: record)
                DispatchQueue.main.async {
                    self.questions.append(question)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        // Оповещает о завершении запроса.
        queryOperation.queryResultBlock = { result in
            switch result {
            case .success(_):
                print("fetch AdminPublicQuestion completed successfully")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        CKContainer.default().publicCloudDatabase.add(queryOperation)
    }
    
    // Перемещаем вопросы в новый Record Type CloudKit.
    func moveQuestionsToNewRecordType() {
        var newRecords: [CKRecord] = []
        let fetchGroup = DispatchGroup()
        
        // Перебирает вопросы и клонирует их в новый Record Type.
        for question in questions {
            fetchGroup.enter()
            let originalRecordID = question.id
            CKContainer.default().publicCloudDatabase.fetch(withRecordID: originalRecordID) { record, error in
                defer { fetchGroup.leave() }
                if let record = record, error == nil {
                    let newRecord = CloudKitService.shared.cloneRecord(original: record, to: "PublicQuestion")
                    newRecords.append(newRecord)
                } else {
                    print("Error fetching while moveQuestionsToNewRecordType record: \(String(describing: error))")
                }
            }
        }
        
        // Сохраняет клонированные записи.
        fetchGroup.notify(queue: .main) {
            self.saveNewRecords(records: newRecords)
        }
    }
    
    // Сохраняет переданные записи в CloudKit.
    func saveNewRecords(records: [CKRecord]) {
        // Создает операцию модификации для сохранения новых записей.
        let modifyOperation = CKModifyRecordsOperation(recordsToSave: records, recordIDsToDelete: nil)
        modifyOperation.modifyRecordsResultBlock = { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("Records successfully moved to new Record Type")
                case .failure(let error):
                    print("Error saving new records: \(error)")
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(modifyOperation)
    }
}

#Preview {
    AdminPublicDetailView(test: CloudTestModel(record: .init(recordType: "PublicQuestion")))
}
