//
//  NewQuestionViewViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.12.2023.
//

import SwiftUI
import CoreData

class NewQuestionViewViewModel: ObservableObject {
    
    @Published var otherAnswers: [Answer] = []
    @Published var questionText = ""
    @Published var answerText = ""
    @Published var alertMessage = ""
    @Published var showingAlert = false
    @Published var questionTextInvalid = false
    @Published var answerTextInvalid = false
    
    func checkTextEditorIsEpmty() -> Bool {
        if questionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            questionTextInvalid.toggle()
            alertMessage = Constants.LocalizedStrings.alertQuestion
            showingAlert.toggle()
            return true
        }
        
        if answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            answerTextInvalid.toggle()
            alertMessage = Constants.LocalizedStrings.alertAnswer
            showingAlert.toggle()
            return true
        }
        
        if otherAnswers.contains(where: { $0.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }) {
            alertMessage = Constants.LocalizedStrings.alertAnswer
            showingAlert.toggle()
            return true
        }
        
        return false
    }
    
    func addOtherAnswer(context: NSManagedObjectContext) {
        let newAnswer = Answer(context: context)
        newAnswer.isCorrect = false
        otherAnswers.append(newAnswer)
    }
    
    func removeOtherAnswer(context: NSManagedObjectContext) {
        otherAnswers.removeLast()
    }
}
