//
//  Persistence.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 23.10.2023.
//

import CoreData
import SwiftUI

struct CoreDataController {
    static let shared = CoreDataController()
    @Environment(\.managedObjectContext) private var viewContext

    //MARK: - Preview
    static var preview: CoreDataController = {
        let result = CoreDataController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = CDTest(context: viewContext)
            newItem.title = "New Test"
            newItem.creationDate = Date()
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
extension CoreDataController {
    
    func deleteEntities<T: NSManagedObject>(offsets: IndexSet, entities: FetchedResults<T>, in context: NSManagedObjectContext) {
        offsets.map { entities[$0] }.forEach(context.delete)
        do {
            try context.save()
        } catch {
            print("Deleting failed: \(error)")
        }
    }
    
    func testWithNameExists(name: String, in context: NSManagedObjectContext) -> Bool {
        let fetchRequest: NSFetchRequest<CDTest> = CDTest.fetchRequest()
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
