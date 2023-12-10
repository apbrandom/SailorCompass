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
                    .applyBackground()
                
            }
            .tabItem {
                Image(systemName: TabBarItem.profile.iconName)
                Text(TabBarItem.profile.title)
            }
            
            
            //
            //            SettingsView()
            //                .tabItem {
            //                    Image(systemName: TabBarItem.settings.iconName)
            //                    Text(TabBarItem.settings.title)
            //                }
            
            
            //            MapView()
            //                .tabItem {
            //                    Image(systemName: TabBarItem.map.iconName)
            //                    Text(TabBarItem.map.title)
            //                }
        }
    }
}

#Preview {
    TabBarView()
}
