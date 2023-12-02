//
//  EditProfileView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 30.11.2023.
//

import SwiftUI

struct EditProfileView: View {
    
    @ObservedObject var vm = CloudKitUserViewModel()
    
    @Binding var nickname: String
    @Binding var vesselName: String
    @Binding var flag: String
    @Binding var signOnDate: String
    @Binding var signOffDate: String
    
    @State var tempNickname = ""
    @State var tempVesselName = ""
    @State var tempFlag = "🏴‍☠️"
    @State var tempSignOnDate = Date()
    @State var tempSignOffDate = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Enter Nickname", text: $tempNickname)
                
                FlagPicker(flag: $tempFlag)
                
                DatePicker("Sign-on Date", selection: $tempSignOnDate, displayedComponents: .date)
                DatePicker("Sign-off Date", selection: $tempSignOffDate, displayedComponents: .date)
                
                TextField("Enter Vessel Name", text: $tempVesselName)
            }
            .navigationTitle("Edit Profile")
            .toolbar() {
                Button("Done") {
                    nickname = tempNickname
                    vesselName = tempVesselName
                    flag = tempFlag
                    signOnDate = DateFormatter.stringFromDate(tempSignOnDate)
                    signOffDate = DateFormatter.stringFromDate(tempSignOffDate)
                    
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .onAppear {
                tempNickname = nickname
                tempVesselName = vesselName
                tempFlag = flag
            }
        }
    }
}

#Preview {
    EditProfileView(vm: CloudKitUserViewModel(),
                            nickname: .constant("Blackbeard"),
                            vesselName: .constant("Adventure Galley"),
                            flag: .constant("🏴‍☠️"),
                            signOnDate: .constant("1 Jan 2023"),
                            signOffDate: .constant("31 Dec 2023"))
}
