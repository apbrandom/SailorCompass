//
//  Answer.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 05.11.2023.
//

import Foundation
import CloudKit

struct CloudQuestionModel: Identifiable {
    let id: UUID
    var testTitle: String
    var text: String
    var publicDate: Date

    init(record: CKRecord) {
        self.id = UUID(uuidString: record.recordID.recordName) ?? UUID()
        self.testTitle = record["testTitle"] as? String ?? "Unknown Test Title"
        self.text = record["text"] as? String ?? "Unknown Text"
        self.publicDate = record.creationDate ?? Date()
    }
}

