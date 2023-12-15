//
//  SavedListTestsViewModel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 14.12.2023.
//

import SwiftUI

class SavedListTestsViewModel: ObservableObject {
    
    @Published var showingAlert = false
    @Published var deletionIndexSet: IndexSet?
    
}
