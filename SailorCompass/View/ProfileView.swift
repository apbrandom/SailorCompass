//
//  ProfileView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = CloudKitUserViewModel()
    
//    @State private var selectedNationality = "🇺🇸"
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal information") {
                    
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Text("\(vm.userName) \(vm.userLastName)")
                    }
                    NationalityPicker()
//                    Picker("Nationality", selection: $vm.selectedNationality) {
//                        Text("🇺🇸").tag("🇺🇸") // США
//                        Text("🇬🇧").tag("🇬🇧") // Великобритания
//                        // Добавьте другие страны
//                    }
                    HStack {
                        Text("iCloud Authorization")
                        Spacer()
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(vm.isSignedIn ? .green : .gray)
                    }
                    HStack {
                        Text("Account Status")
                        Spacer()
                        Text(vm.isAdmin ? "Admin" : "User")
                    }
                }
                Section("Sailing") {
                    Toggle(isOn: $vm.isAtSea) {
                        Text("Currently at Sea")
                    }
                    Text("Sign-on Date")
                    Text("Sign-off Date")
                    Text("Vessel")
                    Text("role on the ship")

                    
                    Text("Company")
                    
                    Text("Location")
                    Text("Miles traveled")
                }
                .navigationTitle("Profile")
            }
        }
    }
}

#Preview {
    ProfileView(vm: .preview)
}
