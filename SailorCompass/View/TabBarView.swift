//
//  TabBarView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct TabBarView: View {
    
    var body: some View {
        TabView{
            NavigationStack {
                MainView()
                    .applyBackground()
            }
            .tabItem {
                Image(systemName: TabBarItem.catalog.iconName)
                Text(TabBarItem.catalog.title)
                
            }
            
            NavigationStack {
                ProfileView()
            }
            .tabItem {
                Image(systemName: TabBarItem.profile.iconName)
                Text(TabBarItem.profile.title)
            }
        }
    }
}

#Preview {
    TabBarView()
}
