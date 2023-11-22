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
    
    var selectedTest: Test
    
    @State private var questionText = ""
    @State private var answerText = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    @State private var questionTextInvalid = false
    @State private var answerTextInvalid = false
    
    var body: some View {
        Form {
            QuestionTextEditor(text: $questionText, isInvalid: $questionTextInvalid)
            Section {
                VStack {
                        HStack {
                            Button {
                            } label: {
                                CheckBoxButtonLabel()
                            }
                            AnswerTextField(text: $answerText, isInvalid: $answerTextInvalid)
                        }
                }
            }
        }
        .navigationTitle("Creation of a new question")
        .navigationBarTitleDisplayMode(.inline)
        
        Button {
            saveToCoreData()
        } label: {
            CustomButtonLabel(text: Constants.LocalizedStrings.save)
        }
        .alert(alertMessage, isPresented: $showingAlert) { }
        .padding()
    }
    
    func saveToCoreData() {
        if questionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            questionTextInvalid.toggle()
            alertMessage = Constants.LocalizedStrings.alertQuestion
            showingAlert.toggle()
            return
        }
        
        if answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            answerTextInvalid.toggle()
            alertMessage = Constants.LocalizedStrings.alertAnswer
            showingAlert.toggle()
            return
        }
 
        let newQuestion = Question(context: viewContext)
        let newAnswer = Answer(context: viewContext)
        newQuestion.text = questionText
        newQuestion.correctAnswer = answerText
        selectedTest.qcount += 1
        newAnswer.question = newQuestion
        newAnswer.isCorrect = true
        newAnswer.text = answerText

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
    NewQuestionView( selectedTest: Test.example)
}
