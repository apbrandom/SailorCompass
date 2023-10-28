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
            NavigationView {
                CatalogTestsView()
            }
            .tabItem {
                Image(systemName: TabBar.catalog.iconName)
                Text(TabBar.catalog.title)
            }
            ProfileView()
                .tabItem {
                    Image(systemName: TabBar.profile.iconName)
                    Text(TabBar.profile.title)
                }
            MapView()
                .tabItem {
                    Image(systemName: TabBar.map.iconName)
                    Text(TabBar.map.title)
                }
            SettingsView()
                .tabItem {
                    Image(systemName: TabBar.settings.iconName)
                    Text(TabBar.settings.title)
                }
        }
    }
}

#Preview {
    TabBarView()
}
