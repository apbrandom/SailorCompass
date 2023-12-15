//
//  CustomTexts.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 15.12.2023.
//

import SwiftUI

struct EmptyViewText: View {
    var body: some View {
        VStack {
            Text("There are no questions added to this test yet.")
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
        }
    }
}

#Preview {
    EmptyViewText()
}
