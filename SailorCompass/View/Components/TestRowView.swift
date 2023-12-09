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
                    .foregroundColor(.blue)
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
            }
            HStack {
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
        .background(Color.customBeige) // Вы можете выбрать любой фоновый цвет
        .cornerRadius(10)
        .shadow(color: .gray, radius: 5, x: 0, y: 2)
    }
}

#Preview {
    TestRowView(test: Test.example)
}
