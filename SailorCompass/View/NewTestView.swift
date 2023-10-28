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
    @State private var testVersion = ""
    @State private var isVersionEnable = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            
            TextField("Enter test name", text: $testName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
               
            HStack(alignment: .bottom) {
                if isVersionEnable {
                    TextField("Enter test version", text: $testVersion)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                Toggle(isVersionEnable ? "" : "Test Version", isOn: $isVersionEnable)
               
                
            }
            .padding(.vertical)
            
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
            .padding()
            .frame(maxWidth: .infinity)
            .background(LinearGradient(colors: [.green, .blue], startPoint: .leading, endPoint: .trailing))
            .font(.title3.bold())
            .foregroundStyle(.white)
            .clipShape(.rect(cornerRadius: 10))
            .contentShape(Rectangle())
            
        }
        .padding()
    }
        
}

#Preview {
    NewTestView()
}
