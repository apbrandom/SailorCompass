//
//  Answer.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 05.11.2023.
//

import CloudKit

struct CloudQuestionModel: Identifiable {
    let id: CKRecord.ID
    var testTitle: String
    var text: String
    var correctAnswer: String
    var publicDate: Date

    init(record: CKRecord) {
        self.id = record.recordID
        self.testTitle = record["testTitle"] as? String ?? "Unknown Test Title"
        self.text = record["text"] as? String ?? "Unknown Text"
        self.correctAnswer = record["correctAnswer"] as? String ?? "Unknown Answer"
        self.publicDate = record.creationDate ?? Date()
    }
}

