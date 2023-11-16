//
//  PublicQuestionsView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 16.11.2023.
//

import SwiftUI
import CloudKit

struct PublicQuestionsView: View {
    
    @State private var questions = [CloudQuestionModel]()
    
    var body: some View {
        List(questions) { question in
            VStack(alignment: .leading) {
                Text(question.text).font(.headline)
                Text("Created: \(question.publicDate, formatter: DateFormatter.shortDate)")
            }
        }
        .onAppear(perform: fetchItems)
    }
    
    func fetchItems() {
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "CD_CDQuestion", predicate: predicate)
            let queryOperation = CKQueryOperation(query: query)
            
            queryOperation.recordMatchedBlock = { (_, result) in
                switch result {
                case .success(let record):
                    let question = CloudQuestionModel(record: record)
                    DispatchQueue.main.async {
                        self.questions.append(question)
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            queryOperation.queryResultBlock = { result in
                switch result {
                case .success(_):
                    print("Запрос успешно завершен")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            CKContainer.default().publicCloudDatabase.add(queryOperation)
        }
}

#Preview {
    PublicQuestionsView()
}
