//
//  CustomTexts.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.12.2023.
//

import SwiftUI

struct EmptyListText: View {
    var body: some View {
        Text("There are no questions added to this test yet.")
            .font(.title)
            .multilineTextAlignment(.center)
            .padding()
    }
}

#Preview {
    EmptyListText()
}
