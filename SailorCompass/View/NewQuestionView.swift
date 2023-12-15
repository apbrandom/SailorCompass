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
    
    @StateObject var vm = NewQuestionViewViewModel()
        
    var body: some View {
        Form {
            QuestionTextEditor(text: $vm.questionText, isInvalid: $vm.questionTextInvalid)
            Section {
                VStack {
                    HStack {
                        Button {
                        } label: {
                            CheckBoxButtonLabel()
                        }
                        AnswerTextField(text: $vm.answerText, isInvalid: $vm.answerTextInvalid)
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
        .alert(vm.alertMessage, isPresented: $vm.showingAlert) { }
        .padding()
    }
    
    func saveToCoreData() {
        if vm.questionText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            vm.questionTextInvalid.toggle()
            vm.alertMessage = Constants.LocalizedStrings.alertQuestion
            vm.showingAlert.toggle()
            return
        }
        
        if vm.answerText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            vm.answerTextInvalid.toggle()
            vm.alertMessage = Constants.LocalizedStrings.alertAnswer
            vm.showingAlert.toggle()
            return
        }
        
        let newQuestion = Question(context: viewContext)
        let newAnswer = Answer(context: viewContext)
        newQuestion.text = vm.questionText
        newQuestion.correctAnswer = vm.answerText
        selectedTest.qcount += 1
        newAnswer.question = newQuestion
        newAnswer.isCorrect = true
        newAnswer.text = vm.answerText
        
        newQuestion.test = selectedTest
        
        do {
            try viewContext.save()
        } catch {
            print("Saving test failed: \(error.localizedDescription)")
        }
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    NewQuestionView( selectedTest: Test.example)
}
