//
//  MyListTestsViewLabel.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct MyListTestsViewLabel: View {
    var body: some View {
            VStack {
                Image(systemName: "externaldrive.badge.person.crop")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                Text("My Tests")
            }
    }
}

struct SharedTestsViewLabel: View {
    var body: some View {
            VStack {
                Image(systemName: "externaldrive.badge.wifi")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                Text("All Tests")
            }
            .padding()
            .background(in: .containerRelative, fillStyle: .init(eoFill: .random()))
            .clipShape(RoundedRectangle(cornerRadius: 10))
        }
}


#Preview {
    VStack{
        MyListTestsViewLabel()
        SharedTestsViewLabel()
    }
}
