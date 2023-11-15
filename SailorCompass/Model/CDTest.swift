//
//  CDTest.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.11.2023.
//
//
import Foundation
import CloudKit

struct TestModel: Identifiable {
    let id: UUID
    var title: String
    var creationDate: Date
    var version: String

    init(record: CKRecord) {
        self.id = UUID(uuidString: record.recordID.recordName) ?? UUID()// или преобразование recordID в UUID
        self.title = record["title"] as? String ?? "Unknown Title"
        self.creationDate = record.creationDate ?? Date()
        self.version = record["version"] as? String ?? "Unknown Version"
    }
}



