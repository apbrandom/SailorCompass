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
                Image(systemName: test.isPublished ? "checkmark.seal.fill" : "")
                    .foregroundColor(.green)
            }
            
            Spacer()
            HStack {
                Image(systemName: "doc.questionmark.fill")
                Text("\(test.qcount)")
    
            }
            HStack {
                HStack {
                    Image(systemName: "ferry.fill")
                    Text("\(test.likes)")
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("Created at:")
                    Text(test.creationDate, formatter: itemFormatter)
                }
                .font(.caption.italic())
                .foregroundStyle(.gray)
            }
        }.padding()
    }
    
    let itemFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter
    }()
}

#Preview {
    TestRowView(test: Test.example)
}
