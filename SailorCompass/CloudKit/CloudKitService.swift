//
//  CloudKitService.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 03.12.2023.
//

import CloudKit

class CloudKitService {
    
    static let shared = CloudKitService()
    
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
    
    func cloneRecord(original: CKRecord, to newType: String) -> CKRecord {
        let newRecord = CKRecord(recordType: newType)
        original.allKeys().forEach { key in
            newRecord[key] = original[key]
        }
        return newRecord
    }
}

