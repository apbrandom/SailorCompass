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
        Form {
            Section {
                TextFieldTestName(text: $testName, isInvalid: $testNameInvalid)
                    .padding(.vertical, 30)
            }
            
            HStack {
                if isVersionEnable {
                    TextFieldTestVesrion(text: $testVersionName, isInvalid: $testVersionInvalid)
                }
                Toggle(isVersionEnable ? Constants.emptyString : Constants.LocalizedStrings.versionName, isOn: $isVersionEnable)
            }
            .padding(.vertical, 30)
            
            HStack {
                Button(action: saveTest) {
                    CustomButtonLabel(text: Constants.LocalizedStrings.save)
                }
                .alert(alertMessage, isPresented: $showingAlert) { }
            }
        }
        .navigationTitle(Constants.LocalizedStrings.newTest)
        .animation(.easeInOut, value: isVersionEnable)
    }
    
    private func saveTest() {
        if testName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            testNameInvalid.toggle()
            alertMessage = Constants.LocalizedStrings.alertTestName
            showingAlert.toggle()
            return
        }
        
        if isVersionEnable && testVersionName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            testVersionInvalid.toggle()
            alertMessage = Constants.LocalizedStrings.alertVersionName
            showingAlert.toggle()
            return
        }
        
        if CoreDataController.shared.testWithNameExists(name: testName, in: viewContext) {
            testNameInvalid.toggle()
            alertMessage = Constants.LocalizedStrings.sameTestName
            showingAlert.toggle()
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
            alertMessage = error.localizedDescription
            showingAlert.toggle()
        }
    }
}

#Preview {
    NewTestView()
}
