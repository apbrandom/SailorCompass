//
//  NewView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct MainView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(fetchRequest: Test.fetch(), animation: .bouncy
    ) var tests: FetchedResults<Test>
    
    @StateObject var vm = CloudKitUserViewModel()
    
    var body: some View {
        ScrollView {
            NavigationLink {
                SavedListTestsView()
                    .applyBackground()
            } label: {
                MainViewCell(icon: CatalogIcon.myTest.icon, title: CatalogIcon.myTest.title)
            }
            
            if !tests.isEmpty {
                NavigationLink {
                    QuizListTestView()
                        .applyBackground()
                } label: {
                    MainViewCell(icon: CatalogIcon.quiz.icon, title: CatalogIcon.quiz.title)
                }
            }
            
            if vm.isAdmin {
                NavigationLink {
                    AdminPublicListView()
                } label: {
                    MainViewCell(icon: CatalogIcon.publicTest.icon, title: CatalogIcon.publicTest.title)
                }
            }
            NavigationLink {
                PublicQuestionsListView()
            } label: {
                MainViewCell(icon: CatalogIcon.publicQuestion.icon, title: CatalogIcon.publicQuestion.title)
            }
        }
        .navigationBarTitleDisplayMode(.large)
        .navigationTitle(Constants.LocalizedStrings.main).tint(Color("PrimaryTextColor"))
    }
}

#Preview {
    MainView()
        .applyBackground()
}
