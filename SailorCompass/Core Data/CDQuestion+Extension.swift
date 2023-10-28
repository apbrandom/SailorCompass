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
    
    static var example: CDQuestion {
        let context = PersistenceController.preview.container.viewContext
        let question = CDQuestion(text: "New Question", context: context)
        return question
    }
    
}
