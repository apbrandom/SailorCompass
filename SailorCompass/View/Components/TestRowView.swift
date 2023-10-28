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
            Text(test.title)
                .font(.title2.bold())
            HStack {
                Text("Questions: 25")
                    
                Spacer()
                VStack(alignment: .leading) {
                    Text("last Updated:")
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
    TestRowView(test: CDTest.example)
}
