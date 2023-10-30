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
    
    @State private var questionImage: Image?
    @State private var questionText = ""
    @State private var answers: [(text: String, isCorrect: Bool)] = [("", true)]
    
    var body: some View {
        VStack {
            TextField("Question text", text: $questionText)
                .textFieldStyle(.roundedBorder)
            ForEach(answers.indices, id: \.self) { index in
                
                HStack {
                    Button {
                        answers[index].isCorrect.toggle()
                    } label: {
                        CheckBoxButtonLabel(isCorrect: answers[index].isCorrect)
                    }
                    TextField("Answer", text: $answers[index].text)
                        .textFieldStyle(.roundedBorder)
                }
                
            }
            
            Button {
                if answers.count < 10 {
                    answers.append((text: "", isCorrect: false))
                }
            } label: {
                Image(systemName: Constants.iconName.plus)
            }

            Button("Add Answer") {
                    if answers.count < 10 {
                        answers.append((text: "", isCorrect: false))
                    }
                }
            
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
        
        for answer in answers {
            let newAnswer = CDAnswer(context: viewContext)
            newAnswer.text = answer.text
            newAnswer.isCorrect = answer.isCorrect
            newAnswer.question = newQuestion
        }
        
        newQuestion.test = selectedTest
        
        do {
            try viewContext.save()
        } catch {
            print("Saving test failed: \(error)")
        }
        presentationMode.wrappedValue.dismiss()
    }
}

//#Preview {
//    NewQuestionView( selectedTest: CDTest.example)
//}
