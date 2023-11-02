//
//  FilteredList.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 31.10.2023.
//

import CoreData
import SwiftUI

struct FilteredList: View {
    
    @FetchRequest var fetchRequest: FetchedResults<CDQuestion>
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
         List {
             ForEach(fetchRequest, id: \.self) { question in
                 Text(question.text)
             }
             .onDelete(perform: deleteItems)
         }
     }
    
    init(with selectedTest: CDTest) {
        let sortDescriptor = NSSortDescriptor(keyPath: \CDQuestion.text_, ascending: true)
        let predicate = NSPredicate(format: "test == %@", selectedTest)
        _fetchRequest = FetchRequest<CDQuestion>(sortDescriptors: [sortDescriptor], predicate: predicate)
    }
    
    private func deleteItems(offsets: IndexSet) {
           withAnimation {
               offsets.map { fetchRequest[$0] }.forEach(viewContext.delete)
               
               do {
                   try viewContext.save()
               } catch {
                   // Здесь нужно обработать ошибку, например, показать какое-то предупреждение пользователю
                   let nsError = error as NSError
                   fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
               }
           }
       }
    
}
    
//    #Preview {
//        FilteredList(filter: <#String#>)
//    }
//    
    
    
    
    
    //import CoreData
    //import SwiftUI
    //
    //struct FilteredList<T: NSManagedObject, Content: View>: View {
    //
    //    @Environment(\.managedObjectContext) var viewContext
    //
    //    @FetchRequest var fetchRequest: FetchedResults<T>
    //    let content: (T) -> Content
    //    var onDelete: (IndexSet) -> Void
    //
    //    var fetchedResults: FetchedResults<T> {
    //        return fetchRequest
    //    }
    //
    //    var body: some View {
    //        List {
    //            ForEach(fetchRequest, id: \.self) { item in
    //                self.content(item)
    //            }
    //            .onDelete(perform: onDelete)
    //        }
    //    }
    //
    //    init(filterKey: String, filterValue: String, onDelete: @escaping (IndexSet) -> Void, @ViewBuilder content: @escaping (T) -> Content) {
    //        _fetchRequest = FetchRequest<T>(sortDescriptors: [], predicate: NSPredicate(format: "%K BEGINSWITH %@", filterKey, filterValue))
    //        self.content = content
    //        self.onDelete = onDelete
    //    }
    //
    //    private func deleteItems(at offsets: IndexSet) {
    //        withAnimation {
    //            offsets.map { fetchRequest[$0] }.forEach(viewContext.delete)
    //            do {
    //                try viewContext.save()
    //            } catch {
    //                // Обработка ошибок здесь
    //                print(error.localizedDescription)
    //            }
    //        }
    //    }
    //}
