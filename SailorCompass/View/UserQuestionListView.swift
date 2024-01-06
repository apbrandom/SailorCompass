//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

//Добавить проверку авторизации и интернета перед отправкой, выввести уведомление что не возможно отпраивить

import SwiftUI
import CoreData
import CloudKit

struct UserQuestionListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var selectedTest: Test
    
    @FetchRequest var questions: FetchedResults<Question>
    @State private var isShowingDeleteAlert = false
    @State private var isShowingPublishAlert = false
    @State private var deletionIndexSet: IndexSet?
    @State private var searchTerm = ""
    @State private var alertMessage = ""
    @State private var isShowingAlert = false
    @State private var isTestApproved: Bool = false
    
    init(selectedTest: Test) {
        self.selectedTest = selectedTest
        let sortDescriptor = NSSortDescriptor(keyPath: \Question.dateCreated, ascending: true)
        let predicate = NSPredicate(format: "test == %@", selectedTest)
        _questions = FetchRequest<Question>(sortDescriptors: [sortDescriptor], predicate: predicate)
    }
    
    var body: some View {
        Group {
            if selectedTest.qcount == 0 {
                EmptyViewText()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .toolbar {
                        NavigationLink {
                            NewQuestionView(selectedTest: selectedTest)
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
            } else {
                List {
                    ForEach(questions, id: \.self) { question in
                        if shouldShowQuestion(question) {
                            NavigationLink {
                                UserQuestionDetailView(question: question)
                            } label: {
                                QuestionRowView(question: question)
                            }
                        }
                    }
                    .onDelete { offsets in
                        deletionIndexSet = offsets
                        isShowingDeleteAlert = true
                    }
                }
                .navigationTitle(selectedTest.title)
                .searchable(text: $searchTerm, prompt: "Serach Question")
                .toolbar {
                    ToolbarItemGroup {
                        if selectedTest.isPending {
                            EditButton()
                            Image(systemName: "checkmark.seal.fill")
                                .foregroundStyle(isTestApproved ? .yellow : .green)
                                .onAppear {
                                    // Проверяем статус теста при появлении view
                                    isTestApproved = !selectedTest.isPending
                                }
                        } else {
                            Button {
                                publishTest(test: selectedTest)
                                isShowingPublishAlert = true
                            } label: {
                                Image(systemName: "paperplane.fill")
                            }
                            NavigationLink {
                                NewQuestionView(selectedTest: selectedTest)
                            } label: {
                                Image(systemName: "plus")
                            }
                            EditButton()
                        }
                    }
                }
                .alert(alertMessage, isPresented: $isShowingAlert) {
                    Button("Ok", role: .cancel, action: { })
                }
                .alert("Are you sure?", isPresented: $isShowingDeleteAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Delete", role: .destructive) {
                        if let offsets = deletionIndexSet {
                            deleteItems(offsets: offsets)
                        }
                    }
                } message: {
                    Text(Constants.LocalizedStrings.qDelitionAlert)
                }
                .alert("Are you sure?", isPresented: $isShowingPublishAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Yes") {
                        publishTest(test: selectedTest)
                    }
                } message: {
                    Text(Constants.LocalizedStrings.publishAlert)
                }
            }
        }
        .applyBackground()
    }
    
    func shouldShowQuestion(_ question: Question) -> Bool {
        if searchTerm.isEmpty {
            return true
        } else {
            return question.text.localizedCaseInsensitiveContains(searchTerm) ||
            question.correctAnswer.localizedCaseInsensitiveContains(searchTerm)
        }
    }
    
    private func publishTest(test: Test) {
        CloudKitManager.shared.publishTest(test: test, context: viewContext) { success in
            DispatchQueue.main.async {
                if success {
                    alertMessage = "Test successfully published."
                    isShowingAlert = true
                } else {
                    alertMessage = "Failed to publish the test. Please check your internet connection and try again."
                    isShowingAlert = true
                }
            }
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        for index in offsets {
            let question = questions[index]
            selectedTest.qcount -= 1
            viewContext.delete(question)
        }
        saveContext()
    }
}

//#Preview {
//    let context = PersistenceController.preview.container.viewContext
//
//    // Получение экземпляра Test для предварительного просмотра
//    let exampleTest = Test.example
//
//    // Возвращение UserQuestionListView в качестве предварительного просмотра
//    UserQuestionListView(selectedTest: exampleTest)
//        .environment(\.managedObjectContext, context)
//}
