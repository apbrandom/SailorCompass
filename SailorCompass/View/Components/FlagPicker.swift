//
//  NationalityPicker.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 29.11.2023.
//

import SwiftUI

struct FlagPicker: View {
    let title = "Flag"
    let countries = Country.Flags
    
    @Binding var flag: String
    
    var body: some View {
        Picker(title, selection: $flag) {
            ForEach(countries.keys.sorted(), id: \.self) { key in
                Text("\(countries[key] ?? "Unknown Country") \(key)").tag(key)
            }
        }
    }
}

#Preview {
    FlagPicker(flag: .constant("🏴‍☠️"))
}



