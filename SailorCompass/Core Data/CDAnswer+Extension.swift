//
//  CDAnswer+Extension.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 30.10.2023.
//

import Foundation
import CoreData

extension CDAnswer {
    
    var text: String {
        get { text_ ?? "" }
        set { text_ = newValue }
    }
    
    //Preview
    static var example: CDAnswer {
        let context = PersistenceController.preview.container.viewContext
        let answer = CDAnswer(text: "New Answer", context: context)
        return answer
    }
    
    convenience init(text: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.text = text
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDAnswer> {
        let request = CDAnswer.fetchRequest()
        request.sortDescriptors = []
        request.predicate = predicate
        return request
    }
    
}


