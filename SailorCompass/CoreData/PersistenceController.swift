//
//  Persistence.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import CoreData
import SwiftUI

struct PersistenceController {
    static let shared = PersistenceController()
    @Environment(\.managedObjectContext) private var viewContext

    //MARK: - Preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newTest = Test(context: viewContext)
            newTest.title = "New Test"
            newTest.creationDate = Date()
            
            for _ in 0..<5 {
                let newQuestion = Question(context: viewContext)
                newQuestion.text = "Sample Question"
                newQuestion.correctAnswer = "Sample Answer"
                newQuestion.test = newTest
            }
        }
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentCloudKitContainer

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "SailorCompass")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    }
}

//MARK: - Methods
extension PersistenceController {
    
    func deleteEntities<T: NSManagedObject>(offsets: IndexSet, entities: FetchedResults<T>, in context: NSManagedObjectContext) {
        offsets.map { entities[$0] }.forEach(context.delete)
        do {
            try context.save()
        } catch {
            print("Deleting failed: \(error)")
        }
    }
    
    func testWithNameExists(name: String, in context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<Test> = Test.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "title_ == %@", name)
        fetchRequest.fetchLimit = 1
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            print("Fetching test failed: \(error.localizedDescription)")
            return false
        }
    }
}
