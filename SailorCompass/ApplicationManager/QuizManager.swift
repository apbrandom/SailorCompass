//
//  QwizManager.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.12.2023.
//

import Foundation

class QuizManager: ObservableObject {
    
    @Published var reachedEnd = false
    @Published private (set) var length = 0
    @Published private (set) var index = 0
    @Published private (set) var answerSelected = false
    @Published private (set) var question = ""
    @Published private (set) var answerChoices: [Answer] = []
    @Published private (set) var progress: CGFloat = 0.00
    @Published private (set) var score = 0
    
    private var questions: [Question] = []
    private var selectedTest: Test
    
    init(selectedTest: Test) {
        self.selectedTest = selectedTest
        Task {
            await loadQuestions()
        }
    }

    func loadQuestions() async {
         do {
             let questions = try await CoreDataManager.shared.fetchQuestions(for: selectedTest)
             DispatchQueue.main.async { [weak self] in
                 self?.questions = questions
                 self?.length = questions.count
                 self?.setQuestion()
             }
         } catch {
             print("Error fetching questions: \(error)")
         }
     }
    
    func goToNextQuestion() {
        if index + 1 < length {
             index += 1
            setQuestion()
        } else {
            reachedEnd = true
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(questions.count))

        if index < questions.count {
            let currentQuestion = questions[index]
            self.question = currentQuestion.text
           
            //print
            print("Текущий вопрос: \(currentQuestion.text)")
            
            if let answersSet = currentQuestion.answers as? Set<Answer> {
                self.answerChoices = Array(answersSet).shuffled()
                
                //print
                print("Ответы: \(self.answerChoices.map { $0.text })")
            } else {
                self.answerChoices = []
            }
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        if answer.isCorrect {
            score += 1
        }
    }
}
