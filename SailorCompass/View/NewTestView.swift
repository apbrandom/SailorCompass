//
//  NewTestView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct NewTestView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var presentationMode
    
    @State private var testName = ""
    
    var body: some View {
        VStack {
            TextField("Enter test name", text: $testName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                let newTest = CDTest(context: viewContext)
                newTest.creationDate = Date()
                newTest.title = testName
                
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
    NewTestView()
}
