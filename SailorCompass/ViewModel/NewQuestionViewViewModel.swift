//
//  NewQuestionViewViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.12.2023.
//

import SwiftUI
import CoreData

class NewQuestionViewViewModel: ObservableObject {
    
//    private var viewContext: NSManagedObjectContext
//
//    init(context: NSManagedObjectContext) {
//        self.viewContext = context
//    }
    
    @Published var otherAnswers: [Answer] = []
    @Published var questionText = ""
    @Published var answerText = ""
    @Published var alertMessage = ""
    @Published var showingAlert = false
    @Published var questionTextInvalid = false
    @Published var answerTextInvalid = false
    
    func addAnotherAnswer(context: NSManagedObjectContext) {
        let newAnswer = Answer(context: context)
        newAnswer.isCorrect = false
        otherAnswers.append(newAnswer)
    }
}
