//
//  QuestionDetailView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 30.10.2023.
//

import SwiftUI

struct QuestionDetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var question: CDQuestion
    
    var body: some View {
        VStack {
            Text(question.text)
        }
    }
    
}

//#Preview {
//    QuestionDetailView()
//        .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
//}
