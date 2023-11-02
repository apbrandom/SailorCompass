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
    @State private var testVersionName = ""
    @State private var alertMessage = ""
    @State private var isVersionEnable = false
    @State private var testNameInvalid = false
    @State private var testVersionInvalid = false
    @State private var showingAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            TextFieldTestName(text: $testName, isInvalid: $testNameInvalid)
            
            HStack(alignment: .bottom) {
                if isVersionEnable {
                    TextFieldTestVesrion(text: $testVersionName, isInvalid: $testVersionInvalid)
                }
                Toggle(isVersionEnable ? "" : "Test Version", isOn: $isVersionEnable)
            }
            .padding(.vertical)
            
            Button(action: saveTest) {
                CustomButtonLabel(text: "Save")
            }
            .padding(.vertical, 40)
        }
        .padding()
        .navigationTitle("Creating a new test")
        .animation(.easeInOut, value: isVersionEnable)
    }
    
    private func saveTest() {
        
        
        let newTest = CDTest(context: viewContext)
        newTest.creationDate = Date()
        newTest.title = testName
        if isVersionEnable {
            newTest.version = testVersionName
        }
        
        do {
            try viewContext.save()
            presentationMode.wrappedValue.dismiss()
        } catch {
            // Здесь должен быть код для обработки ошибок, например:
            // показать alert с информацией об ошибке
            print("Saving test failed: \(error.localizedDescription)")
        }
    }
    
}

#Preview {
    NewTestView()
}
