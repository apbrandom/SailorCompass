//
//  TestsToPublicDetailView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 04.12.2023.
//

import SwiftUI
import CloudKit

struct AdminPublicDetailView: View {
    
    var test: CloudTestModel
    
    @State private var questions = [CloudQuestionModel]()
    
    var body: some View {
        List(questions) { question in
            VStack(alignment: .leading) {
                Text(question.text)
                    .padding(.bottom, 2)
                Text(question.correctAnswer)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 2)
            }
        }
        .navigationTitle(test.title)
        .onAppear(perform: fetchQuestions)
    }
    
    func fetchQuestions() {
        let predicate = NSPredicate(format: "test == %@", test.id)
        let query = CKQuery(recordType: "AdminPublicQuestion", predicate: predicate)
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
                print("fetch AdminPublicQuestion completed successfully")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        CKContainer.default().publicCloudDatabase.add(queryOperation)
    }
}

#Preview {
    AdminPublicDetailView(test: CloudTestModel(record: .init(recordType: "PublicQuestion")))
}
