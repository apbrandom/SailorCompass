//
//  TabBar.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import Foundation

enum TabBar {
    case catalog, map, profile, settings
    
    var title: String {
        switch self {
        case .catalog: return "Catalog"
        case .map: return "Map"
        case .profile: return "Profile"
        case .settings: return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .catalog: return "menucard"
        case .map: return "globe"
        case .profile: return "person.circle"
        case .settings: return "gear"
        }
    }
}
