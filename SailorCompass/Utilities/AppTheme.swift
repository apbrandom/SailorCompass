//
//  AppTheme.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 11.12.2023.
//

import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable {
    case dark, light, system
    var id: String { self.rawValue }
}

extension AppTheme {
    var displayText: String {
        switch self {
        case .dark:
            return "Dark"
        case .light:
            return "Light"
        case .system:
            return "System"
        }
    }
    
    func apply() {
        let style: UIUserInterfaceStyle = {
            switch self {
            case .dark:
                return .dark
            case .light:
                return .light
            case .system:
                return .unspecified
            }
        }()
        
        for windowScene in UIApplication.shared.connectedScenes {
            if let windowScene = windowScene as? UIWindowScene {
                for window in windowScene.windows {
                    window.overrideUserInterfaceStyle = style
                }
            }
        }
    }
}
