//
//  BackgroundModifier.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 09.12.2023.
//

import SwiftUI

struct BackgroundModifier: ViewModifier {
    @Environment(\.colorScheme) var colorScheme
    
    func body(content: Content) -> some View {
        content
            .background(colorScheme == .dark ? Color.backgroundSkyNight : Color.backgroundSkyDay)
    }
}

extension View {
    func applyBackground() -> some View {
        modifier(BackgroundModifier())
    }
}
