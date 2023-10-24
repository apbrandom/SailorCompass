//
//  NewView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct CatalogTestsView: View {
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                NavigationLink(
                    destination:
                        MyListTestsView(),
                    label: {
                        MyListTestsViewLabel()
                    })
                
                NavigationLink(
                    destination:
                        MyListTestsView(),
                    label: {
                        SharedTestsViewLabel()
                    })
            })
        }
        .navigationTitle("Catalog")
    }
}

#Preview {
    CatalogTestsView()
}
