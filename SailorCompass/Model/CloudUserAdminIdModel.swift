//
//  CloudUserAdminId.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 03.12.2023.
//
//
//import Foundation
//import CloudKit
//
//struct CloudUserAdminModel: Identifiable {
//    let id: UUID
//    var userID: String
//    
//    init(record: CKRecord) {
//        self.id = UUID(uuidString: record.recordID.recordName) ?? UUID()
//        self.userID = record["userID"] as? String ?? ""
//    }
//}
