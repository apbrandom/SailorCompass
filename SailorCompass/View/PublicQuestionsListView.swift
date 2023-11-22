//
//  PublicQuestionsView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 16.11.2023.
//

import SwiftUI
import CloudKit

struct PublicQuestionsListView: View {
    
    @State private var questions = [CloudQuestionModel]()
    
    var body: some View {
        List(questions) { question in
            VStack(alignment: .leading) {
                Text(question.testTitle)
                    .font(.headline)
                    .foregroundColor(.blue)
                    .padding(.bottom, 2)

                Text(question.text)
                    .padding(.bottom, 2)

                Text(question.correctAnswer)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 2)
            }
        }
        .onAppear(perform: fetchItems)
    }
    
    func fetchItems() {
            let predicate = NSPredicate(value: true)
            let query = CKQuery(recordType: "PublicQuestion", predicate: predicate)
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
                    print("PublicQuestionList request succses")
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            CKContainer.default().publicCloudDatabase.add(queryOperation)
        }
}

#Preview {
    PublicQuestionsListView()
}
