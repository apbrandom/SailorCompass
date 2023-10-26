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
    
    @State private var questionText = ""
    
    var body: some View {
        VStack {
            TextField("Question text", text: $questionText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                let newTest = Question(context: viewContext)
                newTest.text = questionText
                
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

#Preview {
    NewQuestionView()
}
