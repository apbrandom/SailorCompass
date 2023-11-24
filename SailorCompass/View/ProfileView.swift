//
//  ProfileView.swift
//  SailorCompass
//
//  Created by Vadim Vinogradov on 24.10.2023.
//

import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel = CloudKitUserViewModel()
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .top) {
                Image(systemName: "person.crop.circle.badge.plus")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 80, height: 80)
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        if viewModel.isLoading {
                            ProgressView()
                        } else {
                            Text(viewModel.userName)
                            Text(viewModel.userLastName)
                        }

                    }
                    Text("Nationality")
                    Text("role on the ship")
                }
                .padding()
            }
            .padding()
            Text("On vessel?")
            Text("Company")
            Text("Vessel")
            Text("Location")
            Text("Miles traveled")
            Text("Дата поскадки")
            Text("Примерная дата списания")
            GroupBox {
                Text("IS SIGNED IN :\(viewModel.isSignednToCloud.description) ")
                Text(viewModel.error)
            }
            Spacer()
        }
        .padding()
        
    }
}

#Preview {
    ProfileView()
}
