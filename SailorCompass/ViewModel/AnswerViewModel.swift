//
//  AnswerViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 05.11.2023.
//

import Foundation

class AnswerViewModel: ObservableObject {
    @Published var text: String
    @Published var isCorrect: Bool
    
    init(answer: Answer) {
        self.text = answer.text
        self.isCorrect = answer.isCorrect
    }
}

//#Preview {
//    AnswerViewModel()
//}
