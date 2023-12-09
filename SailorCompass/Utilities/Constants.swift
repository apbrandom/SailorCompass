//
//  Constants.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

enum Constants {
    
    enum LocalizedStrings {
        static let main = "Menu"
        static let savedTests = "Saved Tests"
        static let newTest = "Creating a new test"
        static let save = "Save"
        static let alertTestName = "Please enter the test name in the provied field."
        static let alertVersionName = "Please enter the version name in the provied field."
        static let versionName = "Test Version"
        static let sameTestName = "A test with the same name already exists"
        static let alertQuestion = "Please enter a question in the provided field."
        static let alertAnswer = "Please enter a answer in the provied field."
    }
    
    enum LayoutMetrics {
        static let sreenRatio = 2.4
        static let screen = UIScreen.main.bounds
        static let catalogGridLayout = screen.width / sreenRatio
    }
    
    enum AppSettings {

    }
    
    enum icon {
        static let plus = "plus"
        static let plusCircle = "plus.circle"
        static let minusCircle = "minus.circle"
    }

}
