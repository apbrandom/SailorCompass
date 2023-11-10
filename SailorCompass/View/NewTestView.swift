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
    
    @State private var testTitle = ""
    @State private var testVersionName = ""
    @State private var alertMessage = ""
    @State private var isVersionEnable = false
    @State private var testNameInvalid = false
    @State private var testVersionInvalid = false
    @State private var showingAlert = false
    
    var body: some View {
        Form {
            Section {
                TestTitleTextField(text: $testTitle, isInvalid: $testNameInvalid)
                    .padding(.vertical, 30)
            }
            HStack {
                if isVersionEnable {
                    TestVesrionTextField(text: $testVersionName, isInvalid: $testVersionInvalid)
                }
                Toggle(isVersionEnable ? "" : Constants.LocalizedStrings.versionName, isOn: $isVersionEnable)
            }
            .padding(.vertical, 30)
        }
        .navigationTitle(Constants.LocalizedStrings.newTest)
        .animation(.easeInOut, value: isVersionEnable)
        
        VStack {
            Button(action: saveTest) {
                CustomButtonLabel(text: Constants.LocalizedStrings.save)
            }
            .alert(alertMessage, isPresented: $showingAlert) { }
        }
        .padding()
    }
    
    private func saveTest() {
        if testTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
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
        
        if CoreDataController.shared.testWithNameExists(name: testTitle, in: viewContext) {
            testNameInvalid.toggle()
            alertMessage = Constants.LocalizedStrings.sameTestName
            showingAlert.toggle()
            return
        }
        
        let newTest = CDTest(context: viewContext)
        newTest.id = UUID()
        newTest.creationDate = Date()
        newTest.title = testTitle
        
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
