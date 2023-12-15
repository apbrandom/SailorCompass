//
//  NewQuestionViewViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.12.2023.
//

import Foundation
import CoreData

class NewQuestionViewViewModel: ObservableObject {
    
    @Published var questionText = ""
    @Published var answerText = ""
    @Published var alertMessage = ""
    @Published var showingAlert = false
    @Published var questionTextInvalid = false
    @Published var answerTextInvalid = false

}
