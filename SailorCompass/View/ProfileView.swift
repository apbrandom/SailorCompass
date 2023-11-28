//
//  ProfileView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = CloudKitUserViewModel()
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal information") {
                    
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Text("\(vm.userName) \(vm.userLastName)")
                    }
                    Text("Nationality")
                    HStack {
                        Text("iCloud Status")
                        Spacer()
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(vm.isSignedIn ? .green : .gray)
                    }
                    HStack {
                        Text("Account status")
                        Spacer()
                        Text(vm.isAdmin ? "Admin" : "User")
                    }
                }
                Section("Sailnig") {
                    Text("On vessel?")
                    Text("Дата поскадки")
                    Text("role on the ship")
                    
                    Text("Company")
                    Text("Vessel")
                    Text("Location")
                    Text("Miles traveled")
                    
                    Text("дата списания")
                }
                .navigationTitle("Account")
            }
        }
    }
}

#Preview {
    ProfileView(vm: .preview)
}
