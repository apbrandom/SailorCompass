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
   
    private(set) var selectedAnswer: Answer?
    private var accumulatedPoints = 0.0
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
            finalizeScore()
            
        }
    }
    
    func setQuestion() {
        answerSelected = false
        progress = CGFloat(Double(index + 1) / Double(questions.count))
        
        if index < questions.count {
            let currentQuestion = questions[index]
            self.question = currentQuestion.text
            
            if let answersSet = currentQuestion.answers as? Set<Answer> {
                self.answerChoices = Array(answersSet).shuffled()
            } else {
                self.answerChoices = []
            }
        }
    }
    
    func selectAnswer(answer: Answer) {
        answerSelected = true
        selectedAnswer = answer
        let pointsPerQuestion = Double(100) / Double(length)
        accumulatedPoints += pointsPerQuestion
    }
    
    private func finalizeScore() {
        score = Int(accumulatedPoints.rounded())
    }
    
    func finishTest() {
        index = 0
        accumulatedPoints = 0.0
        score = 0
        answerSelected = false
        reachedEnd = false
        questions = []
        answerChoices = []
    }
}
