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
            TextField("Test Name", text: $testName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Save") {
                let newTest = Test(context: viewContext)
                newTest.timestamp = Date()
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
