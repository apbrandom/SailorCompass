//
//  SDTest+Extension.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 27.10.2023.
//

import Foundation
import CoreData

extension CDTest {
    
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
    convenience init(title: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.creationDate = Date()
    }
    
    static func delete(test: CDTest) {
        guard let context = test.managedObjectContext else { return }
        context.delete(test)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<CDTest> {
        let request = CDTest.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \CDTest.creationDate_, ascending: true),
                                   NSSortDescriptor(keyPath: \CDTest.title_, ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static var example: CDTest {
        let context = PersistenceController.preview.container.viewContext
        let test = CDTest(title: "New Test", context: context)
        return test
    }
}
