//
//  NationalityPicker.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 29.11.2023.
//

import SwiftUI

struct NationalityPicker: View {
    let title = "Nationality"
    let countries = Country.Flags
    
    @State var flag = "🏴‍☠️"
    
    var body: some View {
        Picker(title, selection: $flag) {
            ForEach(countries.keys.sorted(), id: \.self) { key in
                Text("\(countries[key] ?? "Unknown Country") \(key)").tag(key)
            }
        }
    }
}

#Preview {
    NationalityPicker()
}



