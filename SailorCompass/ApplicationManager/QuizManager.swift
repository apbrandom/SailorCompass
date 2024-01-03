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
    
    // Sets up the current question and its associated answer choices.
    func setQuestion() {
        // Resets the flag indicating whether an answer has been selected for the current question.
        answerSelected = false
        
        // Updates the progress of the quiz based on the number of questions answered.
        progress = CGFloat(Double(index + 1) / Double(questions.count))
        
        
        if index < questions.count {
            let currentQuestion = questions[index]
            self.question = currentQuestion.text
            
            // Shuffles the answer choices if available and assigns them to the answerChoices property.
            if let answersSet = currentQuestion.answers as? Set<Answer> {
                self.answerChoices = Array(answersSet).shuffled()
            } else {
                self.answerChoices = []
            }
        }
    }
    
    func selectAnswer(answer: Answer) {
        //Check that the answer has not yet been selected to avoid re-scoring.
        if !answerSelected {
            answerSelected = true
            selectedAnswer = answer
            // Add points only for the correct answer.
            if answer.isCorrect {
                let pointsPerQuestion = Double(100) / Double(length)
                accumulatedPoints += pointsPerQuestion
            }
        }
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
