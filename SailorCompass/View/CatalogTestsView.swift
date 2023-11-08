//
//  NewView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct CatalogTestsView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    private let gridItems = [GridItem(.adaptive(minimum: Constants.LayoutMetrics.catalogGridLayout))]
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: gridItems) {
                NavigationLink {
                    MyListTestsView()
                } label: {
                    CatalogCell(icon: CatalogIcon.myTest.icon, title: CatalogIcon.myTest.title)
                }
                NavigationLink {
                    // TO DO
                } label: {
                    CatalogCell(icon: CatalogIcon.sharedTest.icon, title: CatalogIcon.sharedTest.title)
                }
            }
        }
        .navigationTitle(Constants.LocalizedStrings.catalog)
    }
}

#Preview {
    CatalogTestsView()
}
