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
            Section("Question") {
                QuestionTextEditor(text: $vm.questionText, isInvalid: $vm.questionTextInvalid)
            }
            
            Section("Correct Answer") {
                AnswerTextEditor(text: $vm.answerText, isInvalid: $vm.answerTextInvalid)
            }
            
            Section("Other Answers") {
                ForEach($vm.otherAnswers.indices, id: \.self) { index in
                    AnswerTextEditor(text: $vm.otherAnswers[index].text, isInvalid: $vm.answerTextInvalid)
                }
            }
        }
        .navigationTitle("Creation of a new question")
        .navigationBarTitleDisplayMode(.inline)
        
        VStack {
            HStack {
                if !vm.otherAnswers.isEmpty {
                    Button {
                        vm.removeOtherAnswer(context: viewContext)
                    } label: {
                        PlusMinusButtonLabel(systemImageName: "minus", color: .red)
                    }
                }
                Button {
                    vm.addOtherAnswer(context: viewContext)
                } label: {
                    PlusMinusButtonLabel(systemImageName: "plus", color: .primaryText)
                }
            }
            .padding()
            .padding(.top, 10)
            
            Button {
                saveToCoreData()
            } label: {
                CustomButtonLabel(text: Constants.LocalizedStrings.save, isActive: true)
            }
            .alert(vm.alertMessage, isPresented: $vm.showingAlert) { }
            .padding()
        }
        .animation(.easeIn, value: vm.otherAnswers)
    }
    
    func saveToCoreData() {
        if vm.checkTextEditorIsEpmty() {
            return
        }
                
        let newQuestion = Question(context: viewContext)
        newQuestion.text = vm.questionText
        selectedTest.qcount += 1
        newQuestion.test = selectedTest
        
        let correctAnswer = Answer(context: viewContext)
        newQuestion.correctAnswer = vm.answerText
        correctAnswer.isCorrect = true
        correctAnswer.text = vm.answerText
        correctAnswer.question = newQuestion
        
        for answer in vm.otherAnswers {
            let newAnswer = Answer(context: viewContext)
            newAnswer.text = answer.text
            newAnswer.isCorrect = false
            newAnswer.question = newQuestion
        }
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            vm.alertMessage = "Saving failed: \(error.localizedDescription)"
            vm.showingAlert.toggle()
        }
    }
}

#Preview {
    NewQuestionView( selectedTest: Test.example)
}
