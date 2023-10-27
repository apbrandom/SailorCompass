//
//  NewQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import SwiftUI

struct NewQuestionView: View {
    
    var selectedTest: CDTest
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var questionText = ""
    
    var body: some View {
        VStack {
            TextField("Question text", text: $questionText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                let newQuestion = CDQuestion(context: viewContext)
                newQuestion.text = questionText
                newQuestion.test = selectedTest
                
                do {
                    try viewContext.save()
                } catch {
                    print("Saving test failed: \(error)")
                }
                
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

//#Preview {
//    let context = PersistenceController.preview.container.viewContext
//    let test = Test(context: context)
//    test.timestamp = Date()
//    
//    return NewQuestionView(selectedTest: test)
//                .environment(\.managedObjectContext, context)
//}
