//
//  CDAnswer+Extension.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 30.10.2023.
//

import Foundation
import CoreData

extension Answer {
    
    var text: String {
        get { text_ ?? "" }
        set { text_ = newValue }
    }
    
    //Preview
    static var example: Answer {
        let context = CoreDataController.preview.container.viewContext
        let answer = Answer(text: "New Answer", context: context)
        return answer
    }
    
    convenience init(text: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.text = text
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<Answer> {
        let request = Answer.fetchRequest()
        request.sortDescriptors = []
        request.predicate = predicate
        return request
    }
    
}


