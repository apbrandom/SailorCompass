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
        return test
    }
}


extension CDTest {
    convenience init(record: CKRecord, context: NSManagedObjectContext) {
        self.init(context: context)
        self.title = record["title"] as? String ?? ""
        // Предполагается, что у вас есть атрибуты version и creationDate в CDTest
        // Используйте соответствующие поля из CKRecord для их инициализации
        self.version = record["version"] as? String ?? ""
        self.creationDate = record["creationDate"] as? Date ?? Date()
        // Обратите внимание, что некоторые поля, такие как creationDate, могут быть автоматически установлены CloudKit
        // Вам может потребоваться преобразовать их в соответствующий тип
    }
}
