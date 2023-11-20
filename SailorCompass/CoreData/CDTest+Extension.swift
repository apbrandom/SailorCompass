//
//  SDTest+Extension.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 27.10.2023.
//

import Foundation
import CoreData
import CloudKit

extension CDTest {
    
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
//    var questionCount: Int {
//        get { Int(qcount_) ?? 0 }
//        set { qcount_ = newValue }
//    }
    
        
    convenience init(title: String, version: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.version = version
        self.creationDate = Date()
    }
    
    static func delete(test: CDTest) {
        guard let context = test.managedObjectContext else { return }
        context.delete(test)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDTest> {
        let request = CDTest.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDTest.creationDate_, ascending: false),
                                   NSSortDescriptor(keyPath: \CDTest.title_, ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static var example: CDTest {
        let context = CoreDataController.preview.container.viewContext
        let test = CDTest(context: context)
        test.title = "Title example"
        return test
    }
}
