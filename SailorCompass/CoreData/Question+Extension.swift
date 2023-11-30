//
//  CDQuestion+Extensionq.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 28.10.2023.
//

import Foundation
import CoreData

extension Question {
    
    var text: String {
        get { text_ ?? "Unknown Text" }
        set { text_ = newValue }
    }
    
    var correctAnswer: String {
        get { correctAnswer_ ?? "Unknown Answer" }
        set { correctAnswer_ = newValue }
    }
    
    convenience init(text: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.text = text
    }
    
    static func delete(question: Question) {
        guard let context = question.managedObjectContext else { return }
        context.delete(question)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<Question> {
        let request = Question.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Question.text_, ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static var example: Question {
        let context = CoreDataController.preview.container.viewContext
        let question = Question(context: context)
        return question
    }
}

extension Question {
    var sortedAnswers: [Answer] {
        let set = answers as? Set<Answer> ?? []
        return set.sorted { $0.text < $1.text }
    }
}
