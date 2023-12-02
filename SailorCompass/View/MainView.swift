//
//  NewView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject var vm = CloudKitUserViewModel()
    
    var body: some View {
        ScrollView {
            NavigationLink {
                MyListTestsView()
            } label: {
                CatalogCell(icon: CatalogIcon.myTest.icon, title: CatalogIcon.myTest.title)
            }
            if vm.isAdmin {
                NavigationLink {
                    PublicTestsListView()
                } label: {
                    CatalogCell(icon: CatalogIcon.publicTest.icon, title: CatalogIcon.publicTest.title)
                }
            }
            NavigationLink {
                PublicQuestionsListView()
            } label: {
                CatalogCell(icon: CatalogIcon.publicQuestion.icon, title: CatalogIcon.publicQuestion.title)
            }
        }
        .navigationTitle(Constants.LocalizedStrings.main)
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    MainView()
}
