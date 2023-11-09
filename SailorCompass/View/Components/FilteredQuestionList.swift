//
//  FilteredList.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 31.10.2023.
//

import CoreData
import SwiftUI

struct FilteredQuestionList: View {
    
    @FetchRequest var fetchRequest: FetchedResults<CDQuestion>
    
    @Environment(\.managedObjectContext) private var viewContext
    
    
    var body: some View {
        List {
            ForEach(fetchRequest, id: \.self) { question in
                Section {
                    NavigationLink(destination: QuestionDetailView(question: question)) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(question.text)
                                .font(.headline)
                            Divider()
                            ForEach(question.sortedAnswers, id: \.self) { answer in
                                HStack {
                                    Image(systemName: answer.isCorrect ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(answer.isCorrect ? .green : .secondary)
                                    Text(answer.text)
                                }
                            }
                        }
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    init(with selectedTest: CDTest) {
        let sortDescriptor = NSSortDescriptor(keyPath: \CDQuestion.dateCreated, ascending: true)
        let predicate = NSPredicate(format: "test == %@", selectedTest)
        _fetchRequest = FetchRequest<CDQuestion>(sortDescriptors: [sortDescriptor], predicate: predicate)
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fetchRequest[$0] }.forEach(viewContext.delete)
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

//    #Preview {
//        FilteredQuestionList(with: CDQuestion.example)
//    }
//
//
