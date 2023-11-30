//
//  SDTest+Extension.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 27.10.2023.
//

import Foundation
import CoreData
import CloudKit

extension Test {
    
    var title: String {
        get { title_ ?? "" }
        set { title_ = newValue }
    }
    
    var creationDate: Date {
        get { creationDate_ ?? Date() }
        set { creationDate_ = newValue }
    }
    
    convenience init(title: String, version: String, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = title
        self.version = version
        self.creationDate = Date()
    }
    
    static func delete(test: Test) {
        guard let context = test.managedObjectContext else { return }
        context.delete(test)
    }
    
    static func fetch(_ predicate: NSPredicate = .all) -> NSFetchRequest<Test> {
        let request = Test.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Test.creationDate_, ascending: false),
                                   NSSortDescriptor(keyPath: \Test.title_, ascending: true)]
        request.predicate = predicate
        return request
    }
    
    static var example: Test {
        let context = CoreDataController.preview.container.viewContext
        let test = Test(context: context)
        test.title = "Title example"
        return test
    }
}
