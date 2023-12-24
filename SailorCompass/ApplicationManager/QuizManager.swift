//
//  QwizManager.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import Foundation

class QuizManager: ObservableObject {
    
    @Published private (set) var lenght = 0
    @Published private (set) var index = 0
    @Published private (set) var reachedEnd = false
    @Published private (set) var answeSelected = false
    @Published private (set) var question: AttributedString = ""
    @Published private (set) var answerChoices: [Answer] = []
    @Published private (set) var progress: CGFloat = 0.00
    @Published private (set) var score = 0
    
    func goToNextQuestion() {
        if index + 1 < lenght {
             index += 1
            //Seting a new question here
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answeSelected = false
        progress = CGFloat(Double(index + 1) / Double(lenght * 350))
        
        if index < lenght {
             
        }
    }
    
    func selectAnswer(answer: Answer) {
        answeSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
}
