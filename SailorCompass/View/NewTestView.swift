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
    
    @State private var testName = Constants.emptyString
    @State private var testVersionName = Constants.emptyString
    @State private var alertMessage = Constants.emptyString
    @State private var isVersionEnable = false
    @State private var testNameInvalid = false
    @State private var testVersionInvalid = false
    @State private var showingAlert = false
    
    var body: some View {
        NavigationStack {
            Form {
                TextFieldTestName(text: $testName, isInvalid: $testNameInvalid)
                    .padding(.vertical, 40)
                HStack(alignment: .bottom) {
                    if isVersionEnable {
                        TextFieldTestVesrion(text: $testVersionName, isInvalid: $testVersionInvalid)
                    }
                    Toggle(isVersionEnable ? Constants.emptyString : Constants.LocalizedStrings.versionName, isOn: $isVersionEnable)
                }
                .padding(.vertical)
                
            }
            Button(action: saveTest) {
                CustomButtonLabel(text: Constants.LocalizedStrings.save)
            }
            .padding(.vertical, 40)
            .alert(alertMessage, isPresented: $showingAlert) { }
            .padding()
        }
        .navigationTitle(Constants.LocalizedStrings.newTest)
        .animation(.easeInOut, value: isVersionEnable)
        
    }
    
    private func saveTest() {
        
        if testName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            testNameInvalid = true
            alertMessage = Constants.LocalizedStrings.alertTestName
            showingAlert = true
            return
        }
        
        if isVersionEnable && testVersionName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            testVersionInvalid = true
            alertMessage = Constants.LocalizedStrings.alertVersionName
            showingAlert = true
            return
        }
        
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
