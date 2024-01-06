//
//  CloudKitService.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 03.12.2023.
//

import CloudKit
import CoreData

class CloudKitManager {
    
    static let shared = CloudKitManager()
    
    func fetchAdminUserIDs(completion: @escaping (Result<[String], Error>) -> Void) {
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "UserAdmin", predicate: predicate)
        let queryOperation = CKQueryOperation(query: query)
        var adminUserIDs = [String]()
        
        queryOperation.recordMatchedBlock = { (_, result) in
            switch result {
                
            case .success(let record):
                if let userID = record.object(forKey: "userID") as? String { // Если userID является строкой
                    DispatchQueue.main.async {
                        adminUserIDs.append(userID)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                    return
                }
            }
        }
        
        queryOperation.queryResultBlock = { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    completion(.success(adminUserIDs))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        }
        
        CKContainer.default().publicCloudDatabase.add(queryOperation)
    }
    
    func publishTest(test: Test, context: NSManagedObjectContext, completion: @escaping (Bool) -> Void) {
        CKContainer.default().fetchUserRecordID { (recordID, error) in
            guard let userID = recordID, error == nil else {
                print("Error fetching user record ID: \(String(describing: error))")
                completion(false)
                return
            }
            
            guard let questions = test.questions?.allObjects as? [Question], !questions.isEmpty else {
                print("This test contains no questions. Please ensure at least one question is added.")
                completion(false)
                return
            }
            
            let publicTestRecord = CKRecord(recordType: "PublicTest")
            publicTestRecord["title"] = test.title
            publicTestRecord["version"] = test.version
            publicTestRecord["questionCount"] = test.qcount
            publicTestRecord["UserID"] = userID.recordName
            publicTestRecord["likeCount"] = 0
            publicTestRecord["isPending"] = test.isPending
            
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
                                    context.performAndWait {
                                        test.isPending = true
                                        try? context.save()
                                    }
                                    completion(true)
                                case .failure(let error):
                                    print("Error saving to public database: \(error)")
                                    completion(false)
                                }
                            }
                        }
                        CKContainer.default().publicCloudDatabase.add(modifyRecordsOperation)
                    }
                }
            
    
    
    func updateTestStatus(testID: CKRecord.ID, isPending: Bool, completion: @escaping (Bool) -> Void) {
        let recordID = testID // ID записи теста в CloudKit
        let database = CKContainer.default().publicCloudDatabase
        
        // Получение записи из CloudKit
        database.fetch(withRecordID: recordID) { record, error in
            if let record = record, error == nil {
                // Обновление статуса
                record["isPending"] = isPending
                
                // Сохранение изменений
                database.save(record) { updatedRecord, error in
                    if let updatedRecord = updatedRecord, error == nil {
                        // Успешное сохранение, вызов completion handler
                        DispatchQueue.main.async {
                            completion(true)
                        }
                    } else {
                        // Обработка ошибки
                        print("Error updating record: \(String(describing: error))")
                        DispatchQueue.main.async {
                            completion(false)
                        }
                    }
                }
            } else {
                // Обработка ошибки
                print("Error fetching record: \(String(describing: error))")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }
    
    func updateTestPublishStatus(testID: CKRecord.ID, isPublished: Bool, completion: @escaping (Bool) -> Void) {
        let database = CKContainer.default().publicCloudDatabase
        database.fetch(withRecordID: testID) { record, error in
            if let record = record, error == nil {
                record["isPublished"] = isPublished
                
                database.save(record) { _, error in
                    DispatchQueue.main.async {
                        if error == nil {
                            completion(true)
                        } else {
                            print("Error updating test publish status: \(String(describing: error))")
                            completion(false)
                        }
                    }
                }
            } else {
                print("Error fetching test record: \(String(describing: error))")
                DispatchQueue.main.async {
                    completion(false)
                }
            }
        }
    }

    
    func fetchQuestions(testID: CKRecord.ID, completion: @escaping ([CloudQuestionModel]) -> Void) {
         let predicate = NSPredicate(format: "test == %@", testID)
         let query = CKQuery(recordType: "AdminPublicQuestion", predicate: predicate)
         let operation = CKQueryOperation(query: query)
         
         var questions = [CloudQuestionModel]()
         
         operation.recordMatchedBlock = { (_, result) in
             switch result {
             case .success(let record):
                 let question = CloudQuestionModel(record: record)
                 questions.append(question)
             case .failure(let error):
                 print(error.localizedDescription)
             }
         }
         
         operation.queryResultBlock = { result in
             switch result {
             case .success(_):
                 print("fetch AdminPublicQuestion completed successfully")
                 completion(questions)
             case .failure(let error):
                 print(error.localizedDescription)
                 completion([])
             }
         }
         
         CKContainer.default().publicCloudDatabase.add(operation)
     }
    
    
    func cloneRecord(original: CKRecord, to newType: String) -> CKRecord {
        let newRecord = CKRecord(recordType: newType)
        original.allKeys().forEach { key in
            newRecord[key] = original[key]
        }
        return newRecord
    }
}

