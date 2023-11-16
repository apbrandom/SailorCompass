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
    var text: String
    var publicDate: Date

    init(record: CKRecord) {
        self.id = UUID(uuidString: record.recordID.recordName) ?? UUID()
        self.text = record["CD_text_"] as? String ?? "Unknown Text"
        self.publicDate = record.creationDate ?? Date()
    }
}

