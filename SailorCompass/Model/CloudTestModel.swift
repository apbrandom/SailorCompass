//
//  CDTest.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.11.2023.
//
//

import Foundation
import CloudKit

struct CloudTestModel: Identifiable {
    let id: CKRecord.ID
    var title: String
    var publicDate: Date
    var version: String?

    init(record: CKRecord) {
        self.id = record.recordID
        self.title = record["title"] as? String ?? "Unknown Title"
        self.publicDate = record.creationDate ?? Date()
        self.version = record["version"] 
    }
}



