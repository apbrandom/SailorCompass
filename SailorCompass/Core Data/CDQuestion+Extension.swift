//
//  CDQuestion+Extensionq.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 28.10.2023.
//

import Foundation
import CoreData

extension CDQuestion {
    
    var text: String {
        get { text_ ?? "" }
        set { text_ = newValue }
    }
    
    convenience init(text: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.text = text
        
    }
    
    static func delete(question: CDQuestion) {
        guard let context = question.managedObjectContext else { return }
        context.delete(question)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDQuestion> {
        let request = CDQuestion.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDQuestion.text_, ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static var example: CDQuestion {
        let context = CoreDataController.preview.container.viewContext
        let question = CDQuestion(text: "Example Question Text", context: context)
        return question
    }
}

extension CDQuestion {
    var sortedAnswers: [CDAnswer] {
        let set = answers as? Set<CDAnswer> ?? []
        return set.sorted { $0.text < $1.text }
    }
}
