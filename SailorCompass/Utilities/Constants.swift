//
//  Constants.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

enum Constants {
    
    static let emptyString = ""
    
    enum LocalizedStrings {
        static let catalog = "Catalog"
        static let myTests = "My Tests"
        static let newTest = "Creating a new test"
        static let save = "Save"
        static let alertTestName = "Please enter the test name"
        static let alertVersionName = "Please enter the version name"
        static let versionName = "Test Version"
        static let sameTestName = "A test with the same name already exists"
    }
    
    enum LayoutMetrics {
        static let sreenRatio = 2.4
        static let screen = UIScreen.main.bounds
        static let catalogGridLayout = screen.width / sreenRatio
    }
    
    enum AppSettings {

    }
    
    enum iconName {
        static let plus = "plus"
    }

}
