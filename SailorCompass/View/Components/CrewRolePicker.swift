//
//  CrewRolePicker.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 29.11.2023.
//

import SwiftUI

struct CrewRolePicker: View {
    
    let title = "Crew Role"
    let crew = Crew.role
    
    @State var role = "Passenger"
    
    var body: some View {
        Picker(title, selection: $role) {
            ForEach(crew, id: \.self) { role in
                Text(role).tag(role)
            }
        }
    }
}

#Preview {
    CrewRolePicker()
}
