//
//  TestRowView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 28.10.2023.
//

import SwiftUI

struct TestRowView: View {
    
    @ObservedObject var test: Test
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(test.title)
                    .font(.title2.bold())
                if let version = test.version, !version.isEmpty {
                    Text("v\(version)")
                        .font(.headline)
                }
                Spacer()
                Image(systemName: test.isPublished ? "checkmark.seal.fill" : "checkmark.seal.fill")
                    .foregroundColor(test.isPublished ? .green : .gray)
            }
            
            Spacer()
            HStack {
                Image(systemName: "doc.questionmark.fill")
                Text("\(test.qcount)")
                Spacer()
                VStack(alignment: .leading) {
                    Text("Created at:")
                    Text(test.creationDate, formatter: DateFormatter.shortDate)
                }
                .font(.caption.italic())
                .foregroundStyle(.gray)
            }
        }
        .padding()
        .clipShape(.rect(cornerRadius: 10))
        .background(
            GlassView(removeEffects: true)
            .blur(radius: 10, opaque: true)
        )
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(.white.opacity(0.3), lineWidth: 2)
        )
        .shadow(color: .customGrey.opacity(0.3), radius: 3)
    }
}

#Preview {
    TestRowView(test: Test.example)
        .applyBackground()
}
