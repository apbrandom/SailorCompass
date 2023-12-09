//
//  Colors.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 25.11.2023.
//

import SwiftUI

extension Color {
    static var redToBlue: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.red, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static var grenToBlue: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.green, .blue]), startPoint: .leading, endPoint: .trailing)
    }
    
    static var backgroundSkyDay: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.customBeige, .customSea]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    static var backgroundSkyNight: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [.customBlack, .customSea]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
