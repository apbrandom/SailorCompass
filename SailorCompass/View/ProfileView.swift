//
//  ProfileView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var vm = CloudKitUserViewModel()
    
    @AppStorage("userName") var userName = "Edward"
    @AppStorage("userLastName") var userLastName = "Teach"
    @AppStorage("sailorNickName") var nickname = "Blackbeard"
    
    var body: some View {
        NavigationView {
            Form {
                Section("Personal information") {
                    HStack {
                        Text("iCloud")
                        Image(systemName: "checkmark.seal.fill")
                            .foregroundStyle(vm.isSignedIn ? .green : .gray)
                        Spacer()
                        Text(vm.isAdmin ? "Admin" : "User")
                    }
                    if vm.isLoading {
                        ProgressView()
                    } else {
                        Text("\(userName) \(userLastName)")
                    }
                    Text(nickname)
                    FlagPicker()
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
            .toolbar {
                Button("Edit") {
                    vm.showingEditScreen = true
                }
            }
            .sheet(isPresented: $vm.showingEditScreen) {
                EditProfileView(vm: vm)
            }
        }
    }
}

#Preview {
    ProfileView(vm: .preview)
}
