//
//  MyListQuestionView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 26.10.2023.
//

import SwiftUI
import CoreData

struct QuestionListView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    var selectedTest: CDTest  // Экземпляр выбранного теста передается в этот вид
    
    var body: some View {
        NavigationView {  // Убедитесь, что ваш список находится внутри NavigationView
            FilteredQuestionList(with: selectedTest)
                .navigationTitle(selectedTest.title)  // Используйте имя теста в качестве заголовка
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: NewQuestionView(selectedTest: selectedTest).environment(\.managedObjectContext, viewContext)) {
                            Label("Добавить вопрос", systemImage: Constants.icon.plus)
                        }
                    }
                    ToolbarItem(placement: .navigationBarLeading) {
                        EditButton()
                    }
                }
        }
        .environment(\.managedObjectContext, viewContext)  // Этот модификатор уже не нужен, так как мы используем @Environment для доступа к viewContext
    }
}

#Preview {
    MyListTestsView()
        .environment(\.managedObjectContext, CoreDataController.preview.container.viewContext)
}
