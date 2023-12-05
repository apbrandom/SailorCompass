//
//  SharedTestsView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI
import CloudKit

struct TestsToPublicListView: View {
    
    @State private var tests = [CloudTestModel]()
    
    var body: some View {
            List(tests) { test in
                NavigationLink {
                    TestsToPublicDetailView(test: test)
                } label: {
                    VStack(alignment: .leading) {
                        Text(test.title).font(.headline)
                        if let version = test.version {
                            Text("Version: \(version)")
                        }
                        Text("Publication date: \(test.publicDate, formatter: DateFormatter.shortDate)")
                    }
                }
            }
            .onAppear(perform: fetchItems)
    }
    
    func fetchItems() {
        self.tests = []
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "PublicTest", predicate: predicate)
            let queryOperation = CKQueryOperation(query: query)
            
            queryOperation.recordMatchedBlock = { (_, result) in
                switch result {
                case .success(let record):
                    let test = CloudTestModel(record: record)
                    DispatchQueue.main.async {
                        self.tests.append(test)
                    }
                case .failure(let error):
                    print("Error fetching questions on TestsToPublicListView: \(error.localizedDescription)")
                }
            }
            
            queryOperation.queryResultBlock = { result in
                switch result {
                case .success(_):
                    print("Query from PublicTest completed successfully.")
                case .failure(let error):
                    print("Error in query result from PublicTest: \(error.localizedDescription)")
                }
            }
            CKContainer.default().publicCloudDatabase.add(queryOperation)
        }
}

#Preview {
    TestsToPublicListView()
}
