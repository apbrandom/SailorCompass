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
    @State private var searchText = ""
    
    var body: some View {
//        VStack {
        TextField("Search", text: $searchText)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .padding()
            .onChange(of: searchText) { _ in
                fetchItems()
            }
        
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
//    }
    }
    
    // Необходимо доработать поисковый запрос с CONTAINS
    func fetchItems() {
        self.questions.removeAll()
        
        let predicate: NSPredicate
        let key = "text"
        let value = searchText
        
        if searchText.isEmpty {
            predicate = NSPredicate(value: true)
        } else {
            predicate = NSPredicate(format:"%K BEGINSWITH %@", key, value)
        }
        
        let query = CKQuery(recordType: "PublicQuestion", predicate: predicate)
        
        query.sortDescriptors = [
            NSSortDescriptor(key: key, ascending: true)
        ]
        
        let operation = CKQueryOperation(query: query)
        
        operation.desiredKeys = ["testTitle", "text", "correctAnswer"]
        
        operation.recordMatchedBlock = { (_, result) in
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
        
        operation.queryResultBlock = { result in
            switch result {
            case .success(_):
                print("PublicQuestionList request succses")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        CKContainer.default().publicCloudDatabase.add(operation)
    }
}

#Preview {
    PublicQuestionsListView()
}
