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
//    @Environment(\.managedObjectContext) private var viewContext

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
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
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
        fetchRequest.fetchLimit = 1  // Установите лимит выборки, чтобы ускорить процесс
        
        do {
            let count = try context.count(for: fetchRequest)
            return count > 0
        } catch {
            // Здесь должен быть код для обработки ошибок, например:
            // показать alert с информацией об ошибке
            print("Fetching test failed: \(error.localizedDescription)")
            return false
        }
    }
}
