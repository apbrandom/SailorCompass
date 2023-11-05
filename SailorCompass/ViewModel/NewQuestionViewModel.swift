//
//  NewQuestionViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 05.11.2023.
//

//import SwiftUI
//import CoreData
//
//class NewQuestionViewModel: ObservableObject {
//    
//    var selectedTest: CDTest
//    
//    init(selectedTest: CDTest) {
//        self.selectedTest = selectedTest
//    }
//    
//    @Published var questionText = ""
//    @Published var answerViewModels: [AnswerViewModel] = [AnswerViewModel(answer: Answer(text: "", isCorrect: true))]
//    @Published var isFewAnswer = false
//
//    func toggleCorrectAnswer(index: Int) {
//        if isFewAnswer {
//            answerViewModels[index].isCorrect.toggle()
//        } else {
//            for i in answerViewModels.indices {
//                answerViewModels[i].isCorrect = (i == index)
//            }
//        }
//    }
//
//    func addAnswer() {
//        if answerViewModels.count < 10 {
//            answerViewModels.append(AnswerViewModel(answer: Answer()))
//        }
//    }
//
//    func removeAnswer() {
//        if answerViewModels.count > 1 {
//            answerViewModels.removeLast()
//        }
//    }
//
//    func saveToCD(viewContext: NSManagedObjectContext, selectedTest: CDTest) {
//        let newQuestion = CDQuestion(context: viewContext)
//        newQuestion.text = questionText
//        
//        for answerViewModel in answerViewModels {
//            let newAnswer = CDAnswer(context: viewContext)
//            newAnswer.text = answerViewModel.text
//            newAnswer.isCorrect = answerViewModel.isCorrect
//            newAnswer.question = newQuestion
//        }
//        newQuestion.test = selectedTest
//        
//        do {
//            try viewContext.save()
//        } catch {
//            print("Saving test failed: \(error)")
//        }
//    }
//}
