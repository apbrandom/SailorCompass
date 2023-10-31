//
//  TabBar.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import Foundation

struct TabBarItem {
    let title: String
    let iconName: String
    
    static let catalog = TabBarItem(title: "Catalog", iconName: "menucard")
    static let map = TabBarItem(title: "Map", iconName: "globe")
    static let profile = TabBarItem(title: "Profile", iconName: "person.circle")
    static let settings = TabBarItem(title: "Settings", iconName: "gear")
}
