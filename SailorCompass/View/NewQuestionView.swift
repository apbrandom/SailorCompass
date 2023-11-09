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
    @State private var answers: [(text: String, isCorrect: Bool)] = [("", true)]
    @State private var isFewAnswer = false
    @State private var isAllAnswer = true
    @State private var alertMessage = ""
    @State private var questionTextInvalid = ""
    @State private var answerTextInvalid = ""
    
    var body: some View {
        Form {
            TextEditor(text: $questionText)
                .frame(height: 150)
                .textFieldStyle(.roundedBorder)
            Section {
                VStack {
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
                }
            }
            Toggle("All Answers", isOn: $isAllAnswer)
            Toggle("Multiple correct answers", isOn: $isFewAnswer)
        }
        .navigationTitle("Creation of a new question")
        .navigationBarTitleDisplayMode(.inline)
        
        Group {
            HStack {
                Button {
                    if answers.count < 10 {
                        answers.append((text: "", isCorrect: false))
                    }
                } label: {
                    Image(systemName: Constants.icon.plus)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
            }
                Button {
                    if answers.count > 1 {
                        answers.removeLast()
                    }
                } label: {
                    Image(systemName: Constants.icon.minus)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .padding()
                        .foregroundStyle(.red)
            }
            }
        }
        Button {
            saveToCD()
        } label: {
            CustomButtonLabel(text: "Save")
        }
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

#Preview {
    NewQuestionView( selectedTest: CDTest.example)
}
