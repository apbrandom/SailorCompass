//
//  NewQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import SwiftUI

struct NewQuestionView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    var selectedTest: CDTest
    
    @State private var questionText = ""
    @State private var answerText = ""
    
    var body: some View {
        VStack {
            TextField("Question text", text: $questionText)
                .textFieldStyle(.roundedBorder)
            TextField("Answer", text: $answerText)
                .textFieldStyle(.roundedBorder)
            
            Button {
                saveToCD()
                
            } label: {
                CustomButtonLabel(text: "Save")
            }
        }
        .navigationTitle("Creation of a new question")
        .padding()
    }
    
    func saveToCD() {
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

#Preview {
    NewQuestionView( selectedTest: CDTest.example)
}
