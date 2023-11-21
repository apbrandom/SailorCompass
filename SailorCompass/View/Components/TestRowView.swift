//
//  TestRowView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 28.10.2023.
//

import SwiftUI

struct TestRowView: View {
    
    @ObservedObject var test: CDTest
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack {
                Text(test.title)
                    .font(.title2.bold())
                if let version = test.version, !version.isEmpty {
                    Text("v\(version)")
                        .font(.headline) // Меньший размер шрифта для версии
                }
                
                Spacer()
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(test.isPublished ? .green : .gray)
            }
            
            Spacer()
            HStack {
                Text("Questions: \(test.qcount)")
                
                
                Spacer()
                VStack(alignment: .leading) {
                    Text("Created at:")
                    Text(test.creationDate, formatter: itemFormatter)
                }
                .font(.caption.italic())
                .foregroundStyle(.gray)
            }
            Label(
                title: { Text("\(test.likes)") },
                icon: { Image(systemName: "ferry.fill") }
            )
        }.padding()
    }
    
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

#Preview {
    TestRowView(test: CDTest.example)
}
