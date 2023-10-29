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
                .textFieldStyle(.roundedBorder)
                .onChange(of: testName) { newValue in
                    if newValue.count > 30 {
                        testName = String(testName.prefix(30))
                    }
                }
            
            HStack(alignment: .bottom) {
                if isVersionEnable {
                    TextField("Enter test version", text: $testVersion)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                        .onChange(of: testVersion) { newValue in
                            // Заменяем запятую на точку
                            let replaced = newValue.replacingOccurrences(of: ",", with: ".")
                            
                            // Ограничиваем количество символов до 5
                            if replaced.count > 5 {
                                testVersion = String(replaced.prefix(5))
                            } else {
                                testVersion = replaced
                            }
                        }
                        
                }
                Toggle(isVersionEnable ? "" : "Test Version", isOn: $isVersionEnable)
            }
            .padding(.vertical)
            
            Button {
                let newTest = CDTest(context: viewContext)
                newTest.creationDate = Date()
                newTest.title = testName
                newTest.version = testVersion
                
                do {
                    try viewContext.save()
                } catch {
                    print("Saving test failed: \(error)")
                }
                presentationMode.wrappedValue.dismiss()
            } label: {
                CustomButtonLabel(text: "Save")
            }
            .padding(.vertical, 40)
        }
        .padding()
        .navigationTitle("Creating a new test")
        .animation(.easeInOut, value: isVersionEnable)
    }
}

#Preview {
    NewTestView()
}
