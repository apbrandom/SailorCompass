//
//  SDTest+Extension.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 27.10.2023.
//

import CoreData

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
        let context = PersistenceController.preview.container.viewContext
                let test = Test(context: context)
                test.title = "Title example"
                test.version = "1.0"
                test.qcount = 3
                test.isPublished = false

                let question1 = Question(context: context)
                question1.text = "Question 1 Text"
                question1.correctAnswer = "Answer 1"
                question1.test = test

                let question2 = Question(context: context)
                question2.text = "Question 2 Text"
                question2.correctAnswer = "Answer 2"
                question2.test = test
                return test
    }
}

extension Test {
    var scoresArray: [Int] {
        get {
            guard let data = self.scores else { return [] }
            return (try? PropertyListSerialization.propertyList(from: data, options: [], format: nil)) as? [Int] ?? []
        }
        set {
            self.scores = try? PropertyListSerialization.data(fromPropertyList: newValue, format: .binary, options: 0)
        }
    }
}

