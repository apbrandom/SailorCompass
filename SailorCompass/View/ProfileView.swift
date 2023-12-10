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
    @AppStorage("vesselName") var vesselName = "Adventure Galley"
    @AppStorage("flag") var flag = "🏴‍☠️"
    @AppStorage("signOnDate") var signOnDate = ""
    @AppStorage("signOfDate") var signOfDate = ""
    
    var body: some View {
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
                HStack {
                    Text("Flag")
                    Text(flag)
                }
            }
            
            Section("Achivment") {
                Text("Days at sea")
                Text("Miles traveled")
            }
            
            Section("Sailing") {
                Toggle(isOn: $vm.isAtSea) {
                    Text("Currently at Sea")
                }
                
                HStack {
                    Text("Sign-on Date")
                    Spacer()
                    Text(signOnDate)
                }
                
                HStack {
                    Text("Sign-off Date")
                    Spacer()
                    Text(signOfDate)
                }
                
                HStack {
                    Text("Vessel")
                    Spacer()
                    Text(vesselName)
                }
                
                CrewRolePicker()
                
                Text("Location")
            }
        }
        .navigationTitle("Profile")
        .toolbar {
            Button("Edit") {
                vm.showingEditScreen = true
            }
        }
        .sheet(isPresented: $vm.showingEditScreen) {
            EditProfileView(vm: vm,
                            nickname: $nickname,
                            vesselName: $vesselName,
                            flag: $flag,
                            signOnDate: $signOnDate,
                            signOffDate: $signOfDate)
        }
    }
}
//
//#Preview {
//    ProfileView(vm: .preview)
//}
