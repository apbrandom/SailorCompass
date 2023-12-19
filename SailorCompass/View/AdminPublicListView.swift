//
//  SharedTestsView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI
import CloudKit

struct AdminPublicListView: View {
    
    @State private var tests = [CloudTestModel]()
    
    var body: some View {
        if tests.isEmpty {
            Text("No tests to public")
        }
        
        List {
            ForEach(tests) { test in
                NavigationLink {
                    AdminPublicDetailView(test: test)
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
//            .onDelete(perform: deleteTest)
        }
        .onAppear(perform: fetchItems)
//        .toolbar {
//            EditButton()
//        }
    }
    
//    func deleteTest(at offsets: IndexSet) {
//        // Получаем ID записей для удаления
//        let idsToDelete = offsets.map { tests[$0].id }
//        tests.remove(atOffsets: offsets)
//
//        // Создаем операцию для удаления записей из CloudKit
//        let modifyOperation = CKModifyRecordsOperation(recordsToSave: nil, recordIDsToDelete: idsToDelete)
//        modifyOperation.modifyRecordsResultBlock = { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(_):
//                    print("Records successfully deleted")
//                case .failure(let error):
//                    print("Error deleting records: \(error)")
//                }
//            }
//        }
//        
//        // Добавляем операцию в базу данных CloudKit
//        CKContainer.default().publicCloudDatabase.add(modifyOperation)
//    }

    func fetchItems() {
        self.tests = []
        let predicate = NSPredicate(value: true)
        let query = CKQuery(recordType: "AdminPublicTest", predicate: predicate)
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
                print("Query from AdminPublicTest completed successfully.")
            case .failure(let error):
                print("Error in query result from AdminPublicTest: \(error.localizedDescription)")
            }
        }
        CKContainer.default().publicCloudDatabase.add(queryOperation)
    }
}

#Preview {
    AdminPublicListView()
}
