//
//  QuestionRowView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 28.10.2023.
//

import SwiftUI

struct QuestionRowView: View {
    
    @ObservedObject var question: CDQuestion
    
    var body: some View {
        Text(question.text)
    }
}

#Preview {
    QuestionRowView(question: CDQuestion.example)
}
