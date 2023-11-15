//
//  SharedTestsView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI
import CloudKit

struct PublicTestsView: View {
    
    @State private var tests = [TestModel]()
    
    var body: some View {
        List(tests) { test in
            VStack(alignment: .leading) {
                Text(test.title).font(.headline)
                Text("Created: \(test.creationDate, formatter: DateFormatter.shortDate)")
                Text("Version: \(test.version)")
            }
        }
        .onAppear(perform: fetchItems)
    }
    
    func fetchItems() {
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "CD_CDTest", predicate: predicate)
            let queryOperation = CKQueryOperation(query: query)
            
            queryOperation.recordFetchedBlock = { record in
                let test = TestModel(record: record)
                DispatchQueue.main.async {
                    self.tests.append(test)
                }
            }
            
            queryOperation.queryResultBlock = { result in
                // Обработка результата запроса
            }

            CKContainer.default().publicCloudDatabase.add(queryOperation)
        }
}

#Preview {
    PublicTestsView()
}
