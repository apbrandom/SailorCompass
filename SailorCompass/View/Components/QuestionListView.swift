//
//  QuestionListView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.12.2023.
//

import SwiftUI


struct QuestionRowView: View {
    
    @ObservedObject var question: Question
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(question.text)
                .multilineTextAlignment(.leading)
            Text(question.correctAnswer)
                .font(.subheadline)
                .multilineTextAlignment(.leading)
                .foregroundColor(.secondary)
        }
    }
}

#Preview {
    QuestionRowView(question: Question.example)
}
