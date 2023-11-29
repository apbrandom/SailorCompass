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
                    NationalityPicker()
                    
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
                    
                    DatePicker("Sign-on Date", selection: $vm.signOnDate, displayedComponents: .date)
                    DatePicker("Sign-off Date", selection: $vm.signOfDate, displayedComponents: .date)
                    
                    HStack {
                        Text("Vessel")
                        Spacer()
                        TextField("Enter Vessel Name", text: $vm.vesselName)
                    }
                    
                    CrewRolePicker()
                    
                    Text("Location")
                    Text("Miles traveled")
                }
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView(vm: .preview)
}
